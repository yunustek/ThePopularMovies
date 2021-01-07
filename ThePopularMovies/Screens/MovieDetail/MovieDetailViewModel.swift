//
//  MovieDetailViewModel.swift
//  ThePopularMovies
//
//  Created by Yunus Tek on 7.01.2021.
//

import UIKit

class MovieDetailViewModel: BaseViewModel {

    // MARK: Variables

    var successFetch: (() -> ()) = {}
    var errorFetch: ((Error?) -> ()) = { _ in }
    var loaded: (()->())?

    let movieId: Int
    var isFavorite: Bool

    // MARK: Privates

    var item: Movie? {
        didSet {
            successFetch()
        }
    }
    private(set) var errorClosure: ErrorClosure?
    private(set) var isLoaded: Bool = false {
        didSet {
            if isLoaded {
                loaded?()
            }
        }
    }

    // MARK: Initializations

    init(provider: ProviderProtocol, movieId: Int, isFavorite: Bool) {

        self.movieId = movieId
        self.isFavorite = isFavorite
        
        super.init(provider: provider)

        errorClosure = { [weak self] error in
            guard let self = self else { return }

            self.errorFetch(error)
            self.isLoaded = true
        }
    }

    func fetchMovie() {

        isLoaded = false
        provider.fetchMovie(with: .movie(movieId: movieId), successClosure: { [weak self] movie in
            guard let self = self, let movie = movie else { return }

            self.item = movie
            self.isLoaded = true
        }, errorClosure: errorClosure)
    }

    func fetcImage(imageUrl: String?, widthSize: Int, completion: @escaping (UIImage?) -> Void) {

        guard let urlString = imageUrl else {
            completion(nil)
            return
        }

        provider.fetchImage(with: .image(imageId: urlString, widthSize: widthSize)) { responseImage in

            completion(responseImage)
        } errorClosure: { _ in

        }
    }

    func addToFavorite(movie: Movie?, isFavorite: Bool, success: () -> ()) {

        guard let movie = movie else { return }

        if isFavorite {
            var movies = localStorage.object(forKey: Global.LocalStorage.favoriteMovies, object: [Movie].self) ?? []

            if movies.firstIndex(where: { $0.id == movie.id }) == nil {

                movies.append(movie)
            }

            localStorage.setObject(codableObject: movies, forKey: Global.LocalStorage.favoriteMovies)
        } else {
            guard var movies = localStorage.object(forKey: Global.LocalStorage.favoriteMovies, object: [Movie].self),
                  let index = movies.firstIndex(where: { $0.id == movie.id }) else {
                success()
                return
            }

            movies.remove(at: index)
            localStorage.setObject(codableObject: movies, forKey: Global.LocalStorage.favoriteMovies)
        }
        success()
    }
}

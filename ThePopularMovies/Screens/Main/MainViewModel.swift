//
//  MainViewModel.swift
//  ThePopularMovies
//
//  Created by Yunus Tek on 6.01.2021.
//

import UIKit

class MainViewModel: BaseViewModel {

    // MARK: Variables

    var successFetch: (() -> ()) = {}
    var errorFetch: ((Error?) -> ()) = { _ in }
    var loaded: (()->())?

    // MARK: Privates

    var items: [Movie] = []
    var itemViewModels: [MovieCellViewModel] = []
    private(set) var dataSource: MainCollectionViewDataSource<MovieCell, MovieCellViewModel>! {
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

    override init(provider: ProviderProtocol) {

        super.init(provider: provider)

        errorClosure = { [weak self] error in
            guard let self = self else { return }

            self.errorFetch(error)
            self.isLoaded = true
        }
    }

    func fetchMovies(pageNo: Int) {

        isLoaded = false
        provider.fetchMovies(with: .movies(pageNo: pageNo), successClosure: { [weak self] movies in
            guard let self = self, let movies = movies?.results else { return }

            var viewModels = self.createCellViewModels(movies)
            var newItems = movies

            if var items = self.dataSource?.items {
                items.append(contentsOf: viewModels)
                viewModels = items
                newItems.append(contentsOf: self.items)
            }

            self.items = newItems
            self.itemViewModels = viewModels
            self.dataSource = MainCollectionViewDataSource(items: viewModels)
            self.isLoaded = true
        }, errorClosure: errorClosure)
   }

    func createCellViewModels(_ movies: [Movie]) -> [MovieCellViewModel] {

        var viewModels: [MovieCellViewModel] = []

        let favoriteMovies = localStorage.object(forKey: Global.LocalStorage.favoriteMovies, object: [Movie].self) ?? []

        for movie in movies {

            guard let id = movie.id else { continue }

            let isFavorite = favoriteMovies.firstIndex(where: { $0.id == id }) != nil ? true : false

            viewModels.append(
                MovieCellViewModel(movieId: id,
                                   title: movie.title,
                                   imageURL: movie.poster_path,
                                   isFavorite: isFavorite)
            )
        }
        self.itemViewModels = viewModels
        return viewModels
    }

    func reloadLocalDatas() {

        if let movies = localStorage.object(forKey: Global.LocalStorage.favoriteMovies, object: [Movie].self) {

            var reloadItems = self.items.map { (movie) -> Movie in
                var newMovie = movie
                newMovie.isFavorite = false
                return newMovie
            }

            movies.forEach { (item) in

                if let index = self.items.firstIndex(where: { $0.id == item.id }) {
                    reloadItems[index].isFavorite = true
                }
            }

            dataSource = MainCollectionViewDataSource(items: createCellViewModels(reloadItems))
        }
    }
}

extension MainViewModel: MovieCellDelegate {

    func addToFavoriteButtonTapped(movieId: Int, isFavorite: Bool, success: () -> ()) {

        guard let movie = items.first(where: {$0.id == movieId}) else { return }

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

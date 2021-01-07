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

            if var items = self.dataSource?.items {
                items.append(contentsOf: viewModels)
                viewModels = items
            }

            self.items = movies
            self.itemViewModels = viewModels
            self.dataSource = MainCollectionViewDataSource(items: viewModels)
            self.isLoaded = true
        }, errorClosure: errorClosure)
   }

    func createCellViewModels(_ movies: [Movie]) -> [MovieCellViewModel] {

        var viewModels: [MovieCellViewModel] = []

        let movieFavorites = localStorage.object(forKey: Global.LocalStorage.movieFavorites, object: [Movie].self) ?? movies

        for (index, movie) in movies.enumerated() {

            guard let id = movie.id else { continue }

            viewModels.append(
                MovieCellViewModel(movieId: id,
                                   title: movie.title,
                                   imageURL: movie.poster_path,
                                   isFavorite: movieFavorites[index].isFavorite)
            )
        }

        localStorage.setObject(codableObject: movieFavorites, forKey: Global.LocalStorage.movieFavorites)

        return viewModels
    }

    func reloadLocalDatas() {

        if let movies = localStorage.object(forKey: Global.LocalStorage.movieFavorites, object: [Movie].self),
           !movies.elementsEqual(items) {

            self.items = movies
            self.dataSource = MainCollectionViewDataSource(items: self.createCellViewModels(movies))
        }


    }
}

extension MainViewModel: MovieCellDelegate {

    func addToFavoriteButtonTapped(movieId: Int, isFavorite: Bool, success: () -> ()) {

        guard var movies = localStorage.object(forKey: Global.LocalStorage.movieFavorites, object: [Movie].self),
              let index = movies.firstIndex(where: { $0.id == movieId }) else { return }

        movies[index].isFavorite = isFavorite

        localStorage.setObject(codableObject: movies, forKey: Global.LocalStorage.movieFavorites)
        success()
    }
}

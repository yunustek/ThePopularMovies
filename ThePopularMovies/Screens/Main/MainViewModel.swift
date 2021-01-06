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

    private(set) var dataSource: MainCollectionViewDataSource<MovieCell, MovieCellViewModel>! {
        didSet {
            self.successFetch()
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

        provider.fetchMovies(with: .movies(pageNo: pageNo), successClosure: { [weak self] movies in
            guard let self = self, let movies = movies?.results else { return }

            self.createCellViewModels(movies)
            self.isLoaded = true
        }, errorClosure: errorClosure)
   }

    private func createCellViewModels(_ movies: [Movie]) {

        var viewModels: [MovieCellViewModel] = []

        // TODO: Yunus - save local storage if added to favorite
        let movieFavorites = localStorage.object(forKey: Global.LocalStorage.movieFavorites, object: [Movie].self) as? [Movie]

        for (index, movie) in movies.enumerated() {

            viewModels.append(
                MovieCellViewModel(title: movie.title,
                                   isFavorite: movieFavorites?[index].isFavorite ?? false)
            )
        }

        dataSource = MainCollectionViewDataSource(items: viewModels)
    }
}

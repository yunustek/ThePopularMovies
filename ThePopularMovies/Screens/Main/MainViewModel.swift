//
//  MainViewModel.swift
//  ThePopularMovies
//
//  Created by Yunus Tek on 6.01.2021.
//

class MainViewModel: BaseViewModel {

    var successFetch: (() -> ()) = {}
    var errorFetch: ((Error?) -> ()) = { _ in }
    var errorClosure: ErrorClosure?

    var loaded: (()->())?

    var isLoaded: Bool = false {
        didSet {
            if isLoaded {
                loaded?()
            }
        }
    }

    private(set) var movies: [Movie]! {
        didSet {
            self.successFetch()
        }
    }

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

            self.movies = movies
            self.isLoaded = true
        }, errorClosure: errorClosure)
   }
}

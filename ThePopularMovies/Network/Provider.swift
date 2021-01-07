//
//  Provider.swift
//  ThePopularMovies
//
//  Created by Yunus Tek on 6.01.2021.
//

import UIKit

class Provider : ProviderProtocol {

    func fetchMovies(with endpoint: RequestAPI, successClosure: @escaping SuccessClosure<Movies>, errorClosure: ErrorClosure?) {

        let request = endpoint.requestApi
        fetch(with: request, successClosure: successClosure, errorClosure: errorClosure)
    }

    func fetchMovie(with endpoint: RequestAPI, successClosure: @escaping SuccessClosure<Movie>, errorClosure: ErrorClosure?) {

        let request = endpoint.requestApi
        fetch(with: request, successClosure: successClosure, errorClosure: errorClosure)
    }

    func fetchImage(with endpoint: RequestAPI, successClosure: @escaping SuccessClosure<UIImage>, errorClosure: ErrorClosure?) {

        let request = endpoint.requestImage
        fetch(with: request, successClosure: successClosure, errorClosure: errorClosure)
    }
}

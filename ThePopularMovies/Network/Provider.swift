//
//  Provider.swift
//  ThePopularMovies
//
//  Created by Yunus Tek on 6.01.2021.
//

import Foundation

class Provider : ProviderProtocol {

    static let baseUrl = Configuration.apiURL

    func fetchMovies(with endpoint: RequestAPI, successClosure: @escaping SuccessClosure<Movies>, errorClosure: ErrorClosure?) {

        let request = endpoint.request
        fetch(with: request, successClosure: successClosure, errorClosure: errorClosure)
    }
}

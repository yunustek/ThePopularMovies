//
//  ProviderProtocol.swift
//  ThePopularMovies
//
//  Created by Yunus Tek on 6.01.2021.
//

import Foundation

protocol ProviderProtocol: RequestProtocol {

    func fetchMovies(with endpoint: RequestAPI, successClosure: @escaping SuccessClosure<Movies>, errorClosure: ErrorClosure?)
}

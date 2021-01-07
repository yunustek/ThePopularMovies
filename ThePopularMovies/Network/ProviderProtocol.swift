//
//  ProviderProtocol.swift
//  ThePopularMovies
//
//  Created by Yunus Tek on 6.01.2021.
//

import UIKit

protocol ProviderProtocol: RequestProtocol {

    func fetchMovies(with endpoint: RequestAPI, successClosure: @escaping SuccessClosure<Movies>, errorClosure: ErrorClosure?)

    func fetchMovie(with endpoint: RequestAPI, successClosure: @escaping SuccessClosure<Movie>, errorClosure: ErrorClosure?)

    func fetchImage(with endpoint: RequestAPI, successClosure: @escaping SuccessClosure<UIImage>, errorClosure: ErrorClosure?)
}

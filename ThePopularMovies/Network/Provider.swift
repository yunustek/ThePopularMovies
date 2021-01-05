//
//  Provider.swift
//  ThePopularMovies
//
//  Created by Yunus Tek on 5.01.2021.
//

import Foundation

enum ResponseStatus<T> {

    case success(T)
    case error(Error)
}

enum ServiceError : Error {

    case unknown, badResponse, jsonDecoder, imageDownload, imageConvert
}

protocol Provider {

    var session: URLSession { get }
    func getFetch<T: Codable>(with request: URLRequest, completion: @escaping (ResponseStatus<[T]>) -> Void)
}

extension Provider {

    var session : URLSession {
        return URLSession.shared
    }

    func getFetch<T: Codable>(with request: URLRequest, completion: @escaping (ResponseStatus<[T]>) -> Void) {

        let task = session.dataTask(with: request) { (data, response, error) in
            guard error == nil else {
                completion(.error(error!))
                return
            }

            guard let response = response as? HTTPURLResponse, 200..<300 ~= response.statusCode else {
                completion(.error(ServiceError.badResponse))
                return
            }

            guard let value = try? JSONDecoder().decode([T].self, from: data!) else {
                 completion(.error(ServiceError.jsonDecoder))
                return
            }

            DispatchQueue.main.async {
                completion(.success(value))
            }
        }
        task.resume()
    }
}

//
//  RequestProtocol.swift
//  ThePopularMovies
//
//  Created by Yunus Tek on 5.01.2021.
//

import Foundation

typealias SuccessClosure<Model: Codable> = (_ model: Model?) -> Void
typealias ErrorClosure = (_ error: Error?) -> Void

enum ResponseError : Error {

    case unknown, badResponse, jsonDecoder(Error), nildata
}

protocol RequestProtocol {

    var session: URLSession { get }
    func fetch<Model: Codable>(with request: URLRequest, successClosure: @escaping SuccessClosure<Model>, errorClosure: ErrorClosure?)
}

extension RequestProtocol {

    var session : URLSession {
        return URLSession.shared
    }

    func fetch<Model: Codable>(with request: URLRequest,
                               successClosure: @escaping SuccessClosure<Model>,
                               errorClosure: ErrorClosure?) {

        session.configuration.timeoutIntervalForRequest = Configuration.timeoutForRequest

        let task = session.dataTask(with: request) { (data, response, error) in
            guard error == nil else {
                errorClosure?(error!)
                return
            }

            guard let response = response as? HTTPURLResponse, 200..<300 ~= response.statusCode else {
                errorClosure?(ResponseError.badResponse)
                return
            }

            guard let data = data else {
                errorClosure?(ResponseError.nildata)
                return
            }

            do {
                let decoder = JSONDecoder()
                let value = try decoder.decode(Model.self, from: data)

                DispatchQueue.main.async {

                    successClosure(value)
                }
            } catch {
                
                errorClosure?(ResponseError.jsonDecoder(error))
                return
            }
        }
        task.resume()
    }
}

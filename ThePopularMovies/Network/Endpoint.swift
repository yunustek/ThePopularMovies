//
//  Endpoint.swift
//  ThePopularMovies
//
//  Created by Yunus Tek on 6.01.2021.
//

import Foundation

protocol Endpoint {

    var baseUrl : String { get }
    var path: String { get }
    var parameters: [URLQueryItem] { get }
    var auth: [URLQueryItem] { get }
}

extension Endpoint {

    var urlComponent : URLComponents {

        var urlComponent = URLComponents(string: baseUrl)
        urlComponent?.path.append(path)

        urlComponent?.queryItems = []
        urlComponent?.queryItems?.append(contentsOf: auth)
        urlComponent?.queryItems?.append(contentsOf: parameters)

        return urlComponent!
    }

    var request: URLRequest {

        debugPrint("Fetching \(urlComponent.queryItems ?? []) fetching on \(type(of: self))")
        return URLRequest(url: urlComponent.url!)
    }
}

enum RequestAPI : Endpoint {

    case movies(pageNo: Int)
    case movie(movieId: String)
}

extension RequestAPI {

    var baseUrl: String {

        return Configuration.apiURL
    }

    var path : String {

        switch self {
        case .movies:
            return "/movie/popular"
        case .movie(let movieId):
            return "/movie/\(movieId)"
        }
    }

    var parameters: [URLQueryItem] {

        switch self {
        case .movies(let pageNo):
            return [ URLQueryItem(name: "page", value: String(pageNo) ) ]
        case .movie:
            return []
        }
    }

    var auth: [URLQueryItem] {

        return [URLQueryItem(name: "api_key", value: "fd2b04342048fa2d5f728561866ad52a" ),
                URLQueryItem(name: "language", value: "en-US" )]
    }
}

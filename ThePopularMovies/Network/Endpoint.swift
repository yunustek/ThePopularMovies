//
//  Endpoint.swift
//  ThePopularMovies
//
//  Created by Yunus Tek on 6.01.2021.
//

import UIKit

protocol Endpoint {

    var baseUrl : String { get }
    var baseImageUrl : String { get }
    var path: String { get }
    var parameters: [URLQueryItem] { get }
    var auth: [URLQueryItem] { get }
}

extension Endpoint {

    var urlComponent: URLComponents {

        var urlComponent = URLComponents(string: baseUrl)
        urlComponent?.path.append(path)

        parameters.forEach { item in

            if urlComponent?.queryItems == nil {
                urlComponent?.queryItems = []
            }

            urlComponent?.queryItems?.append(item)
        }

        auth.forEach { item in

            if urlComponent?.queryItems == nil {
                urlComponent?.queryItems = []
            }

            urlComponent?.queryItems?.append(item)
        }

        return urlComponent!
    }

    var imageUrlComponent: URLComponents {

        var urlComponent = URLComponents(string: baseImageUrl)
        urlComponent?.path.append(path)

        parameters.forEach { item in

            if urlComponent?.queryItems == nil {
                urlComponent?.queryItems = []
            }

            urlComponent?.queryItems?.append(item)
        }

        return urlComponent!
    }

    var requestApi: URLRequest {

        debugPrint("Fetching \(String(describing: urlComponent.url?.absoluteString))")
        return URLRequest(url: urlComponent.url!)
    }

    var requestImage: URLRequest {

        debugPrint("Fetching \(String(describing: imageUrlComponent.url?.absoluteString))")
        return URLRequest(url: imageUrlComponent.url!)
    }
}

enum RequestAPI : Endpoint {

    case movies(pageNo: Int)
    case movie(movieId: Int)
    case image(imageId: String, widthSize: Int)
}

extension RequestAPI {

    var baseUrl: String {

        return Configuration.apiURL
    }

    var baseImageUrl: String {

        return Configuration.baseImageUrl
    }

    var apiKey: String {

        return Configuration.apiKey
    }

    var path : String {

        switch self {
        case .movies:
            return "/movie/popular"
        case .movie(let movieId):
            return "/movie/\(movieId)"
        case .image(let imageId, let widthSize):
            return "w\(widthSize)/\(imageId)"
        }
    }

    var parameters: [URLQueryItem] {

        switch self {
        case .movies(let pageNo):
            return [ URLQueryItem(name: "page", value: String(pageNo) ) ]
        case .movie:
            return []
        case .image:
            return []
        }
    }

    var auth: [URLQueryItem] {

        return [URLQueryItem(name: "api_key", value: apiKey ),
                URLQueryItem(name: "language", value: "en-US" )]
    }
}

//
//  RequestProtocol.swift
//  ThePopularMovies
//
//  Created by Yunus Tek on 5.01.2021.
//

import UIKit

typealias SuccessClosure<Model> = (_ model: Model?) -> Void
typealias ErrorClosure = (_ error: Error?) -> Void

enum ResponseError : Error {

    case unknown, badResponse, jsonDecoder(Error), nildata, imageConvert, imageDownload
}

protocol RequestProtocol {

    var session: URLSession { get }
    func fetch<Model: Codable>(with request: URLRequest, successClosure: @escaping SuccessClosure<Model>, errorClosure: ErrorClosure?)
}

extension RequestProtocol {

    var session : URLSession {

        let urlSession = URLSession.shared
        urlSession.configuration.timeoutIntervalForRequest = Configuration.timeoutForRequest
        return urlSession
    }

    func fetch(with request: URLRequest,
                    successClosure: @escaping SuccessClosure<UIImage>,
                    errorClosure: ErrorClosure?) {

        guard let url = request.url else {
            errorClosure?(ResponseError.badResponse)
            return
        }

        DispatchQueue.global(qos: .background).async {

            guard let imageData = try? Data(contentsOf: url) else {
                errorClosure?(ResponseError.imageDownload)
                return
            }

            guard let image = UIImage(data: imageData) else {
                errorClosure?(ResponseError.imageConvert)
                return
            }

            DispatchQueue.main.async {

                successClosure(image)
            }
        }

//        let task = session.downloadTask(with: request, completionHandler: { (downloadedUrl, response, error) in
//
////        let task = session.downloadTask(with: url) { (downloadedUrl, response, error) in
//            guard let downloadedUrl = downloadedUrl else {
//                errorClosure?(ResponseError.badResponse)
//                return
//            }
//
//            var urlPath = URL(fileURLWithPath: NSTemporaryDirectory())
//            let uniqueURLEnding = "\(ProcessInfo.processInfo.globallyUniqueString)"
//            urlPath = urlPath.appendingPathComponent(uniqueURLEnding)
//
//            var mediaExtension = response?.url?.pathExtension ?? ""
//            mediaExtension = mediaExtension.isEmpty ? "jpg" : mediaExtension
//            urlPath = urlPath.appendingPathExtension(mediaExtension)
//
//            try? FileManager.default.moveItem(at: downloadedUrl, to: urlPath)
//
//            completion(UIImage(contentsOfFile: urlPath.absoluteString))
//        })
//        task.resume()
    }

    func fetch<Model>(with request: URLRequest,
                               successClosure: @escaping SuccessClosure<Model>,
                               errorClosure: ErrorClosure?) where Model: Decodable {

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

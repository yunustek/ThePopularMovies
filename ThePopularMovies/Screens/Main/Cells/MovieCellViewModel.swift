//
//  MovieCellViewModel.swift
//  ThePopularMovies
//
//  Created by Yunus Tek on 6.01.2021.
//

import UIKit

final class MovieCellViewModel: BaseCellViewModel {


    let movieId: Int
    let title: String?
    var posterImageUrl: String?
    var isFavorite: Bool

    let provider = Provider()

    init(movieId: Int, title: String?, imageURL: String?, isFavorite: Bool) {

        self.movieId = movieId
        self.title = title
        self.isFavorite = isFavorite
        self.posterImageUrl = imageURL
        super.init()
    }

    func fetcImage(imageUrl: String?, widthSize: Int, completion: @escaping (UIImage?) -> Void) {

        guard let urlString = imageUrl else {
            completion(nil)
            return
        }

        provider.fetchImage(with: .image(imageId: urlString, widthSize: widthSize)) { responseImage in

            completion(responseImage)
        } errorClosure: { _ in

        }
    }
}

// BaseCellDataProtocol

extension MovieCellViewModel: BaseCellDataProtocol {

    static var reuseIdentifier: String {

         return String(describing: MovieCell.self)
     }

     var reuseIdentifier: String {

         return MovieCell.reuseIdentifier
     }
}

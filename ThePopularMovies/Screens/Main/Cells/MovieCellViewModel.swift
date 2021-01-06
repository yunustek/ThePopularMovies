//
//  MovieCellViewModel.swift
//  ThePopularMovies
//
//  Created by Yunus Tek on 6.01.2021.
//

import Foundation

final class MovieCellViewModel: BaseCellViewModel {

    let title: String?
    let isFavorite: Bool

    init(title: String?, isFavorite: Bool) {

        self.title = title
        self.isFavorite = isFavorite
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

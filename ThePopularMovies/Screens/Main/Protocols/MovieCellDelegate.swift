//
//  MovieCellDelegate.swift
//  ThePopularMovies
//
//  Created by Yunus Tek on 7.01.2021.
//

import Foundation

protocol MovieCellDelegate {

    func addToFavoriteButtonTapped(movieId: Int, isFavorite: Bool, success: () -> ())
}

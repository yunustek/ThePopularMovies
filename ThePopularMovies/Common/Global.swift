//
//  Global.swift
//  ThePopularMovies
//
//  Created by Yunus Tek on 6.01.2021.
//

import Foundation

public enum Global {

    enum LocalStorage {

        static let favoriteMovies = "FavoriteMovies"
    }

    enum Storyboard: String {

        case main = "Main"
        case movieDetail = "MovieDetail"
    }
}

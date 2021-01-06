//
//  BaseCellViewModel.swift
//  ThePopularMovies
//
//  Created by Yunus Tek on 6.01.2021.
//

import Foundation

class BaseCellViewModel {

    deinit {
        #if DEBUG
        print("\(type(of: self)): Deinited")
        #endif
    }
}

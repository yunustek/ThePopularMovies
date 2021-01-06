//
//  StringExtensions.swift
//  ThePopularMovies
//
//  Created by Yunus Tek on 6.01.2021.
//

import Foundation

extension String {

    var replaceXConfigCharacters: String {
        
        return self.replacingOccurrences(of: "#", with: "//")
    }
}

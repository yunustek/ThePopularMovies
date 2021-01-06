//
//  ReuseProtocol.swift
//  ThePopularMovies
//
//  Created by Yunus Tek on 6.01.2021.
//

import Foundation

public protocol ReuseProtocol {

    static var reuseIdentifier: String { get }
    var reuseIdentifier: String { get }
}

public extension ReuseProtocol {

    static var reuseIdentifier: String {

        return String(describing: self)
    }

    var reuseIdentifier: String {

        return type(of: self).reuseIdentifier
    }
}

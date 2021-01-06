//
//  StoryboardProtocol.swift
//  ThePopularMovies
//
//  Created by Yunus Tek on 6.01.2021.
//

import UIKit

public protocol StoryboardProtocol: ReuseProtocol {

    static var storyboardName: String { get }
}

public extension StoryboardProtocol {

    static func instantiate() -> Self {

        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        guard let viewController = storyboard.instantiateViewController(withIdentifier: reuseIdentifier) as? Self else {
            fatalError(reuseIdentifier + " cannot be instantiated via storyboard")
        }

        return viewController
    }
}

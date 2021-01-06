//
//  NibProtocol.swift
//  ThePopularMovies
//
//  Created by Yunus Tek on 6.01.2021.
//

import UIKit

public protocol NibProtocol: class {

    static var nib: UINib { get }
}

public extension NibProtocol {

    static var nib: UINib {

        return UINib(nibName: String(describing: self), bundle: nil)
    }
}

public extension NibProtocol where Self: UIView {

    static func instanceFromNib() -> Self {

        guard let view = nib.instantiate(withOwner: nil, options: nil).first as? Self else {
            fatalError("The nib \(nib) expected its root view to be of type \(self)")
        }

        return view
    }
}

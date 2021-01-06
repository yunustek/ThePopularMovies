//
//  UICollectionViewExtension.swift
//  ThePopularMovies
//
//  Created by Yunus Tek on 6.01.2021.
//

import UIKit

extension UICollectionView {

    func registerCell<T: NibProtocol & ReuseProtocol>(type: T.Type) {

        register(type.nib, forCellWithReuseIdentifier: type.reuseIdentifier)
    }
}

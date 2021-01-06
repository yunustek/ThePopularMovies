//
//  MainCollectionViewDataSource.swift
//  ThePopularMovies
//
//  Created by Yunus Tek on 6.01.2021.
//

import UIKit

class MainCollectionViewDataSource<Cell: BaseCollectionViewCell, T>: NSObject, UICollectionViewDataSource {

    private var items: [BaseCellViewModel]!
    var configureCell: ((BaseCollectionViewCell, BaseCellViewModel) -> ())? = { _,_ in }

    init(items : [BaseCellViewModel], configureCell: ((BaseCollectionViewCell, BaseCellViewModel) -> ())? = nil) {
        self.items =  items
        self.configureCell = configureCell
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCell.reuseIdentifier, for: indexPath) as? MovieCell else {
            fatalError("UICollectionViewCell must be downcasted to MovieCell")
        }

        let item = items[indexPath.row]
        configureCell?(cell, item)
        cell.bind(to: item)

        return cell
    }
}

//
//  MainCollectionViewFlowLayout.swift
//  ThePopularMovies
//
//  Created by Yunus Tek on 6.01.2021.
//

import UIKit

enum DisplayMode {

    case list
    case grid
}

class MainCollectionViewFlowLayout : UICollectionViewFlowLayout {

    // MARK: Variables

    var width: CGFloat {
        return collectionView?.frame.width ?? 0
    }

    var mode : DisplayMode = .grid {
        didSet {
            if mode != oldValue {
                self.invalidateLayout()
            }
        }
    }

    // MARK: Initializations

    convenience init(displayMode: DisplayMode) {
        self.init()

        self.mode = displayMode
        self.minimumLineSpacing = 10
        self.minimumInteritemSpacing = 10
        self.configureDisplayMode()
    }

    func configureDisplayMode() {

        guard let collectionView = collectionView else { return }
        scrollDirection = .vertical

        switch mode {
        case .list:

            itemSize = CGSize(width: collectionView.frame.width , height: 130)
        case .grid:

            let newWidth = (width - (minimumInteritemSpacing + sectionInset.left + sectionInset.right)) / 2
            itemSize = CGSize(width: newWidth , height: newWidth)
        }
    }

    override func invalidateLayout() {

        super.invalidateLayout()
        configureDisplayMode()
    }
}

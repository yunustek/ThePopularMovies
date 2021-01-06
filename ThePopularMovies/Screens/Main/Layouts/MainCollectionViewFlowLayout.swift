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

    var displayMode: DisplayMode = .grid {
        didSet {
            if displayMode != oldValue {
                self.invalidateLayout()
            }
        }
    }

    // MARK: Initializations

    convenience init(displayMode: DisplayMode) {
        self.init()

        self.displayMode = displayMode
        self.minimumLineSpacing = 10
        self.minimumInteritemSpacing = 10
        self.configureDisplayMode()
    }

    func configureDisplayMode() {

        guard let _ = collectionView else { return }
        
        scrollDirection = .vertical

        switch displayMode {
        case .list:

            itemSize = CGSize(width: width , height: width / 2)
        case .grid:

            let newWidth = (width - (minimumInteritemSpacing + sectionInset.left + sectionInset.right)) / 2
            itemSize = CGSize(width: newWidth , height: newWidth * 1.5)
        }
    }

    override func invalidateLayout() {

        super.invalidateLayout()
        configureDisplayMode()
    }
}

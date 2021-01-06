//
//  BaseCollectionViewCell.swift
//  ThePopularMovies
//
//  Created by Yunus Tek on 6.01.2021.
//

import UIKit

class BaseCollectionViewCell: UICollectionViewCell, NibProtocol, ReuseProtocol {

    override func awakeFromNib() {

        super.awakeFromNib()
        applyStyling()
    }

    override func prepareForReuse() {

        super.prepareForReuse()
    }

    func bind(to viewModel: BaseCellViewModel) {

    }

    func applyStyling() {

        backgroundColor = .clear
    }
}

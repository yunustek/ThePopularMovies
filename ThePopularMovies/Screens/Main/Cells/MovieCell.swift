//
//  MovieCell.swift
//  ThePopularMovies
//
//  Created by Yunus Tek on 6.01.2021.
//

import UIKit

final class MovieCell: BaseCollectionViewCell {

    enum Constant {

        enum Animation {
            static let duration = 0.3
        }
    }

    // MARK: Outlets

    @IBOutlet private weak var imageView: UIImageView!

    // MARK: Variables

    private var orginalImage: UIImage!
    private var grayImage: UIImage!

    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func prepareForReuse() {

        super.prepareForReuse()

    }

    override func bind(to viewModel: BaseCellViewModel) {

        guard let model = viewModel as? MovieCellViewModel else { return }

    }

    override func applyStyling() {

        super.applyStyling()
    }
}

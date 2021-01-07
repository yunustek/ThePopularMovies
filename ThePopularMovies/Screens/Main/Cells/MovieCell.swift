//
//  MovieCell.swift
//  ThePopularMovies
//
//  Created by Yunus Tek on 6.01.2021.
//

import UIKit

final class MovieCell: BaseCollectionViewCell {

    enum Constant {

        static let imageSize: Int = 200 // dynamic size is not supported. Ex: w414
    }

    // MARK: Outlets

    @IBOutlet private weak var posterImageView: UIImageView!
    @IBOutlet private weak var favoriteImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!

    // MARK: Variables

    var viewModel: MovieCellViewModel!
    private var delegate: MovieCellDelegate!

    override func awakeFromNib() {

        super.awakeFromNib()

    }

    override func prepareForReuse() {

        super.prepareForReuse()

        self.posterImageView.image = nil
        self.favoriteImageView.image = nil
        self.titleLabel.text = nil
    }

    override func bind(to viewModel: BaseCellViewModel) {

        guard let model = viewModel as? MovieCellViewModel else { return }

        favoriteImageView.image = model.isFavorite ? #imageLiteral(resourceName: "favoriteStar.png") : nil

        titleLabel.text = model.title

        model.fetcImage(imageUrl: model.posterImageUrl, widthSize: Constant.imageSize) { [weak self] image in

            self?.posterImageView.image = image
        }
    }

    override func applyStyling() {

        super.applyStyling()

        self.layer.cornerRadius = 10
        self.layer.masksToBounds = true
    }

    // MARK: Actions

    @IBAction func addToFavorite(_ sender: Any) {

        delegate.addToFavoriteButtonTapped(movieId: viewModel.movieId, isFavorite: !viewModel.isFavorite) { [weak self] in
            guard let self = self else { return }

            self.viewModel.isFavorite = !self.viewModel.isFavorite
            self.favoriteImageView.image = self.viewModel.isFavorite ? #imageLiteral(resourceName: "favoriteStar.png") : nil
        }
    }
}

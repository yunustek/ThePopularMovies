//
//  MovieDetailViewController.swift
//  ThePopularMovies
//
//  Created by Yunus Tek on 7.01.2021.
//

import UIKit

class MovieDetailController: BaseViewController {

    enum Constant {

        static let imageSize: Int = 400 // dynamic size is not supported. Ex: w414
    }

    // MARKS: Outlets

    @IBOutlet private weak var posterImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var descLabel: UITextView!
    @IBOutlet private weak var voteCountLabel: UILabel!

    // MARKS: Variables
    var viewModel: MovieDetailViewModel!
    var isFavoriteButton: UIBarButtonItem!
    var totalItemCount = 0
    var itemPageNumber = 1

    override func viewDidLoad() {

        configureNavigationButtons()

        super.viewDidLoad()
    }

    override func bindViewModel() {

        super.bindViewModel()

        isFavoriteButton.image = viewModel.isFavorite ? #imageLiteral(resourceName: "favoriteStar.png") : #imageLiteral(resourceName: "unFavoriteStar")

        viewModel.successFetch = { [weak self] in
            guard let self = self, let item = self.viewModel.item else { return }

            self.titleLabel.text = item.title
            self.descLabel.text = item.description
            self.voteCountLabel.text = "Vote Count: \(item.voteCount ?? -1))"

            self.viewModel.fetcImage(imageUrl: item.poster_path, widthSize: Constant.imageSize) { [weak self] image in

                self?.posterImageView.image = image
            }
        }

        viewModel.loaded = {

            print("loaded")
        }

        viewModel.errorFetch = { [weak self] error in
            guard let _ = self else { return }

            print("Error fetch!", error?.localizedDescription ?? "")
        }

        viewModel.fetchMovie()
    }

    override func applyStyling() {

        super.applyStyling()

        navigationItem.title = "Content Detail"
        titleLabel.text = ""
        descLabel.text = ""
        voteCountLabel.text = ""
    }

    private func configureNavigationButtons() {

        isFavoriteButton = UIBarButtonItem(image: #imageLiteral(resourceName: "unFavoriteStar"), style: .plain, target: self, action: #selector(changeFavorite))

        navigationItem.rightBarButtonItem = isFavoriteButton
    }

    @objc func changeFavorite() {

        viewModel.addToFavorite(movieId: viewModel.movieId, isFavorite: !viewModel.isFavorite) {
            
            viewModel.isFavorite = !viewModel.isFavorite
            if viewModel.isFavorite {

                isFavoriteButton.image = #imageLiteral(resourceName: "favoriteStar")
            } else {

                isFavoriteButton.image = #imageLiteral(resourceName: "unFavoriteStar")
            }
        }
    }
}

// MARK: - StoryboardProtocol

extension MovieDetailController: StoryboardProtocol {

    static var storyboardName: String = Global.Storyboard.movieDetail.rawValue
}

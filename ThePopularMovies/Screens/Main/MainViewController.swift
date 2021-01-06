//
//  MainViewController.swift
//  ThePopularMovies
//
//  Created by Yunus Tek on 5.01.2021.
//

import UIKit

class MainViewController: BaseViewController {

    enum Constant {

        enum CollectionView {

            static let sectionInset = UIEdgeInsets(top: 12, left: 8, bottom: 8, right: 12)
            static let minimumLineSpacing: CGFloat = 10
            static let minimumInteritemSpacing: CGFloat = 10
        }
    }

    // MARKS: Outlets

    @IBOutlet private weak var collectionView: UICollectionView!

    // MARKS: Variables
    var viewModel = MainViewModel(provider: Provider())

    override func viewDidLoad() {

        super.viewDidLoad()

        configureCollectionView()
        configureCollectionViewLayout()
        registerCollectionViewCells()
    }

    override func bindViewModel() {

        super.bindViewModel()

        viewModel.successFetch = { [weak self] in
            guard let self = self else { return }

            self.collectionView.reloadData()
        }

        viewModel.loaded = {

            print("loaded")
        }

        viewModel.errorFetch = { [weak self] error in
            guard let self = self else { return }

            print("ERROR FETCH!!", error?.localizedDescription)
        }

        viewModel.fetchMovies(pageNo: 2)
    }

    override func applyStyling() {

        super.applyStyling()
    }

    private func configureCollectionView() {

        collectionView.isScrollEnabled = true
        collectionView.isPagingEnabled = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = true
    }

    private func configureCollectionViewLayout() {

        let collectionViewlayout = UICollectionViewFlowLayout()
        collectionViewlayout.scrollDirection = .vertical
        collectionViewlayout.minimumLineSpacing = Constant.CollectionView.minimumLineSpacing
        collectionViewlayout.minimumInteritemSpacing = Constant.CollectionView.minimumInteritemSpacing
        collectionViewlayout.footerReferenceSize = .zero
        collectionViewlayout.headerReferenceSize = .zero
        collectionViewlayout.itemSize = UIScreen.main.bounds.size
        collectionViewlayout.sectionInset = Constant.CollectionView.sectionInset
        collectionView.collectionViewLayout = collectionViewlayout
    }

    private func registerCollectionViewCells() {

        collectionView.registerCell(type: MovieCell.self)
    }
}

// MARK: - StoryboardProtocol

extension MainViewController: StoryboardProtocol {

    static var storyboardName: String = Global.Storyboard.Main.name
}

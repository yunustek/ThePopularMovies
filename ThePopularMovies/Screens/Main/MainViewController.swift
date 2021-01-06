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

        let layout = MainCollectionViewFlowLayout(displayMode: .list)
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = Constant.CollectionView.minimumLineSpacing
        layout.minimumInteritemSpacing = Constant.CollectionView.minimumInteritemSpacing
        layout.footerReferenceSize = .zero
        layout.headerReferenceSize = .zero
        layout.itemSize = UIScreen.main.bounds.size
        layout.sectionInset = Constant.CollectionView.sectionInset
        collectionView.collectionViewLayout = layout
    }

    private func registerCollectionViewCells() {

        collectionView.registerCell(type: MovieCell.self)
    }
}

// MARK: - StoryboardProtocol

extension MainViewController: StoryboardProtocol {

    static var storyboardName: String = Global.Storyboard.Main.name
}

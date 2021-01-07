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
    let collectionViewLayout = MainCollectionViewFlowLayout()
    var changeDisplayModeButton: UIBarButtonItem!
    var itemPageNumber = 1

    override func viewDidLoad() {

        super.viewDidLoad()

        configureCollectionView()
        configureCollectionViewLayout()
        registerCollectionViewCells()
        configureNavigationButtons()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        viewModel.reloadLocalDatas()
    }

    override func bindViewModel() {

        super.bindViewModel()

        viewModel.successFetch = { [weak self] in
            guard let self = self else { return }

            self.reloadData()
        }

        viewModel.loaded = {

            print("loaded")
        }

        viewModel.errorFetch = { [weak self] error in
            guard let _ = self else { return }

            print("Error fetch!!", error?.localizedDescription ?? "")
        }

        viewModel.fetchMovies(pageNo: itemPageNumber)
    }

    override func applyStyling() {

        super.applyStyling()

        navigationItem.title = "Contents"
    }

    private func reloadData() {

        self.collectionView.dataSource = viewModel.dataSource
        self.collectionView.reloadData()
    }

    private func configureNavigationButtons() {

        changeDisplayModeButton = UIBarButtonItem(image: #imageLiteral(resourceName: "iconGrid.png"), style: .plain, target: self, action: #selector(changeDisplayMode))

        navigationItem.rightBarButtonItem = changeDisplayModeButton
    }

    @objc func changeDisplayMode() {

        if collectionViewLayout.displayMode == .list {

            collectionViewLayout.displayMode = .grid
            changeDisplayModeButton.image = #imageLiteral(resourceName: "iconList.png")
        } else {

            collectionViewLayout.displayMode = .list
            changeDisplayModeButton.image = #imageLiteral(resourceName: "iconGrid.png")
        }
    }

    private func configureCollectionView() {

        collectionView.delegate = self
        collectionView.isScrollEnabled = true
        collectionView.isPagingEnabled = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = true
    }

    private func configureCollectionViewLayout() {

        collectionViewLayout.displayMode = .list
        collectionViewLayout.scrollDirection = .vertical
        collectionViewLayout.minimumLineSpacing = Constant.CollectionView.minimumLineSpacing
        collectionViewLayout.minimumInteritemSpacing = Constant.CollectionView.minimumInteritemSpacing
        collectionViewLayout.footerReferenceSize = .zero
        collectionViewLayout.headerReferenceSize = .zero
        collectionViewLayout.itemSize = UIScreen.main.bounds.size
        collectionViewLayout.sectionInset = Constant.CollectionView.sectionInset
        collectionView.collectionViewLayout = collectionViewLayout
    }

    private func registerCollectionViewCells() {

        collectionView.registerCell(type: MovieCell.self)
    }
}

extension MainViewController: UICollectionViewDelegate, UIScrollViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        let viewController = MovieDetailController.instantiate()

        let item = viewModel.dataSource.items[indexPath.item]
        viewController.viewModel = MovieDetailViewModel(provider: Provider(),
                                                        movieId: item.movieId,
                                                        isFavorite: item.isFavorite)

        self.push(viewController)
    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {

        let lastElement = viewModel.dataSource.items.count - 1
        if viewModel.isLoaded, indexPath.item == lastElement {

            itemPageNumber += 1
            viewModel.fetchMovies(pageNo: itemPageNumber)
        }
    }
}

// MARK: - StoryboardProtocol

extension MainViewController: StoryboardProtocol {

    static var storyboardName: String = Global.Storyboard.main.rawValue
}

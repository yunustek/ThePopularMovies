//
//  BaseViewController.swift
//  ThePopularMovies
//
//  Created by Yunus Tek on 6.01.2021.
//

import UIKit

class BaseViewController: UIViewController, BaseController {

    var localStorage: LocalStorageProtocol! {
        return LocalStorage(userDefaults: UserDefaults.standard)
    }

    override func viewDidLoad() {

        super.viewDidLoad()

        applyStyling()
        bindViewModel()
    }

    func bindViewModel() {

    }

    func applyStyling() {

    }

    // Coordinator

    func push(_ viewController: UIViewController, animated: Bool = true) {

        self.navigationController?.pushViewController(viewController, animated: animated)
    }

    func push(storyboardName: Global.Storyboard, animated: Bool = true) {

        let storyboard = UIStoryboard(name: storyboardName.rawValue, bundle: nil)
        let controller = storyboard.instantiateInitialViewController()
        self.push(controller!, animated: animated)
    }
}

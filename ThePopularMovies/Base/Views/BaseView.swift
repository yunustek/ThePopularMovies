//
//  BaseView.swift
//  ThePopularMovies
//
//  Created by Yunus Tek on 6.01.2021.
//

import UIKit

class BaseView: UIView, NibProtocol {

    override func awakeFromNib() {

        super.awakeFromNib()

        applyStyling()
    }

    func bind(to viewModel: BaseCellViewModel) {

    }

    func applyStyling() {

    }

    deinit {
        #if DEBUG
        print("\(type(of: self)): Deinited")
        #endif
    }
}

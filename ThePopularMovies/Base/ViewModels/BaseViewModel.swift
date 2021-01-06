//
//  BaseViewModel.swift
//  ThePopularMovies
//
//  Created by Yunus Tek on 6.01.2021.
//

import Foundation

class BaseViewModel: NSObject {

    let provider: ProviderProtocol

    init(provider: ProviderProtocol) {

        self.provider = provider
        super.init()
    }

    deinit {
        #if DEBUG
        print("\(type(of: self)): Deinited")
        #endif
    }
}

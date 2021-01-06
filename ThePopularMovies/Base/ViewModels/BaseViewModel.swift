//
//  BaseViewModel.swift
//  ThePopularMovies
//
//  Created by Yunus Tek on 6.01.2021.
//

import UIKit

class BaseViewModel: NSObject, BaseController {

    let provider: ProviderProtocol

    var localStorage: LocalStorageProtocol! {
        return LocalStorage(userDefaults: UserDefaults.standard)
    }

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

//
//  LocalStorage.swift
//  ThePopularMovies
//
//  Created by Yunus Tek on 6.01.2021.
//

import UIKit

final public class LocalStorage: NSObject, LocalStorageProtocol {

    private var userDefaults: UserDefaults?
    private let prefix: String! = try! Configuration.value(for: "BUNDLE_IDENTIFIER")

    // MARK: Initializations

    init(userDefaults: UserDefaults?) {
        super.init()
        self.userDefaults = userDefaults
    }

    // MARK: Getter Methods

    func object<T: Decodable>(forKey key: Any, object: T.Type) -> T? {

        let reKey = reformKey(key as? String)

        if let data = userDefaults?.object(forKey: reKey) as? Data {
            return try? PropertyListDecoder() .decode(T.self, from: data)
        }
        return userDefaults?.object(forKey: reKey) as? T
    }

    func string(forKey key: String) -> String? {
        let object = userDefaults?.string(forKey: reformKey(key))
        if object != nil {
            return "\(object ?? "")"
        }
        return nil
    }

    // MARK: Setter Methods

    func setObject<T>(codableObject: T?, forKey key: String?) where T: Codable {
        userDefaults?.set(try? PropertyListEncoder().encode(codableObject), forKey: reformKey(key))
        synchronize()
    }

    func setObject(_ object: Any?, forKey key: String?) {
        userDefaults?.set(object, forKey: reformKey(key))
        synchronize()
    }

    func store(_ value: String?, forKey key: String?) {
        userDefaults?.set(value, forKey: reformKey(key))
        synchronize()
    }

    // MARK: Accessor Methods

    func removeObject(forKey key: String) {
        userDefaults?.removeObject(forKey: reformKey(key))
        synchronize()
    }

    // MARK: Privates

    private func reformKey(_ key: String?) -> String {
        return "\(prefix ?? "")_\(key ?? "")"
    }

    private func synchronize() {
        CFPreferencesAppSynchronize(kCFPreferencesCurrentApplication)
    }

    private func unformKey(_ key: String?) -> String? {
        return key?.replacingOccurrences(of: self.prefix, with: "")
    }
}

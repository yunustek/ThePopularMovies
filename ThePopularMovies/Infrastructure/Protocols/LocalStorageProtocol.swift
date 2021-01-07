//
//  LocalStorageProtocol.swift
//  ThePopularMovies
//
//  Created by Yunus Tek on 6.01.2021.
//

import UIKit

protocol LocalStorageProtocol: NSObjectProtocol {

    // MARK: Getter Methods

    /**
    * Get an object with key from LocalStorage
    * @param key     key to get its value
    * @return Object value if found
    */
    func object<T: Decodable>(forKey key: Any, object: T.Type) -> T?

    /**
    * Get an string with key from LocalStorage
    * @param key      key to get its value
    * @return String value if found
    */
    func string(forKey key: String) -> String?

    // MARK: Setter Methods

    /**
    * Store object in LocalStorage
    * @param object the object we want to store in LocalStorage
    * @param key    key which save with the value
    */
    func setObject(_ object: Any?, forKey key: String?)

    /**
    * Store object in LocalStorage
    * @param object the object we want to store in LocalStorage
    * @param key    key which save with the value
    */
    func setObject<T>(codableObject: T?, forKey key: String?) where T: Codable

    /**
    * Store string in LocalStorage
    * @param string the string we want to store in LocalStorage
    * @param key   key which save with the value
    */
    func store(_ value: String?, forKey key: String?)

    /**
    * Method which allows to remove a value from LocalStorage.
    *
    * @param key key of value we want to delete
    */
    func removeObject(forKey key: String)
}

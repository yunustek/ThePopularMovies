//
//  Configuration.swift
//  ThePopularMovies
//
//  Created by Yunus Tek on 6.01.2021.
//

import Foundation

enum Configuration {

    enum ConfigError: Swift.Error {

        case missingPlistKey, invalidValue
    }

    private static func contents() -> [String : AnyObject] {

        guard let resource = Bundle.main.object(forInfoDictionaryKey: "Configurations"),
              let contents = resource as? [String : AnyObject] else { return [:] }
        return contents
    }

    static func value<T>(for key: String) throws -> T? where T: LosslessStringConvertible {

        guard let object = contents()[key] else {
            throw ConfigError.missingPlistKey
        }

        switch object {
        case let value as T:
            return (value as? String)?.isEmpty ?? false ? nil : value
        case let string as String:
            guard let value = T(string) else { fallthrough }
            return value
        default:
            throw ConfigError.invalidValue
        }
    }

    static var apiURL: URL {

        let content: String! = try! Configuration.value(for: "API_BASE_URL")
        return URL(string: content.replaceXConfigCharacters)!
    }

    static var bundleID: String {

        let content: String! = try! Configuration.value(for: "BUNDLE_IDENTIFIER")
        return content
    }
}

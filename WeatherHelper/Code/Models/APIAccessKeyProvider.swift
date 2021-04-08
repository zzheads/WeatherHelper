//
//  APIAccessKeyProvider.swift
//  WeatherHelper
//
//  Created by Алексей Папин on 08.04.2021.
//

import Foundation

protocol ProvidesPlist: AnyObject {
    subscript<T>(_ key: StringRawValueable) -> T? { get }
    subscript(_ rawValue: String) -> Any? { get }
}

final class PlistProvider {
    static let `extension` = "plist"

    private let dictionary: NSDictionary

    init?(fileName: String) {
        guard
            let path = Bundle.main.path(forResource: fileName, ofType: PlistProvider.extension),
            let dictionary = NSDictionary(contentsOfFile: path)
        else { return nil }
        self.dictionary = dictionary
    }
}

extension PlistProvider: ProvidesPlist {
    subscript<T>(_ key: StringRawValueable) -> T? {
        dictionary.value(forKey: key.rawValue) as? T
    }

    subscript(_ rawValue: String) -> Any? {
        dictionary.value(forKey: rawValue)
    }
}

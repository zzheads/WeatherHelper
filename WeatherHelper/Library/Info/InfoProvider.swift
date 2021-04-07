//
//  InfoManager.swift
//  ZConcept
//
//  Created by Alexey Papin on 27/10/2019.
//  Copyright © 2019 Alexey Papin. All rights reserved.
//

import Foundation

protocol IInfoProvider {
    var apiHostUrl: String { get }
    var apiKey: String { get }
}

class InfoProvider {
    private enum Key: String {
        case apiHostUrl = "API Host Url"
        case apiKey = "API Key"
    }
    
    private func valueForKey(_ key: Key) -> Any? {
        return infoDictionary[key.rawValue]
    }
    
    private var infoDictionary: [String: Any] {
        guard let infoDictionary = Bundle.main.infoDictionary else {
            fatalError("Failed to get info.plist dictionary")
        }

        return infoDictionary
    }
}

extension InfoProvider: IInfoProvider {
    var apiHostUrl: String {
        guard let apiUrl = valueForKey(.apiHostUrl) as? String else {
            fatalError("Failed to get API Host Url from info.plist")
        }

        return apiUrl
    }
    
    var apiKey: String {
        guard let apikey = valueForKey(.apiKey) as? String else {
            fatalError("Failed to get API Host Url from info.plist")
        }

        return apikey
    }
}

extension InfoProvider: HTTPRequestAdapterDataSource {
    func hostUrl() -> URL {
        guard let url = URL(string: self.apiHostUrl) else {
            fatalError("Bad URL ")
        }
        return url
    }
    
    func valueForHTTPHeaderKey(_ key: String) -> String? {
        guard let key = Key(rawValue: key) else {
            return nil
        }
        return valueForKey(key) as? String
    }
}

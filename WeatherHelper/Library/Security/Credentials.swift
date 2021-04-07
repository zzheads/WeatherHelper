//
//  Credentials.swift
//  ZConcept
//
//  Created by Alexey Papin on 26/10/2019.
//  Copyright © 2019 Alexey Papin. All rights reserved.
//

import Foundation

protocol ICredentials {
    var tokenType: String? { get set }
    var accessToken: String? { get set }
}

// MARK: - Credentials
struct Credentials {
    enum Key: String {
        case accessToken
        case tokenType
    }
    
    // Dependencies
    
    private let userDefaults: UserDefaults
    
    // MARK: - Init
    
    init(userDefaults: UserDefaults = .standard) {
        self.userDefaults = userDefaults
    }

    private func set<T>(_ value: T?, forKey key: Key) {
        userDefaults.setValue(value, forKey: key.rawValue)
    }

    private func getValue<T>(forKey key: Key) -> T? {
        userDefaults.value(forKey: key.rawValue) as? T
    }
}

// MARK: - ICredentials
extension Credentials: ICredentials {
    var accessToken: String? {
        get { getValue(forKey: .accessToken) }
        set { set(newValue, forKey: .accessToken) }
    }

    var tokenType: String? {
        get { getValue(forKey: .tokenType) }
        set { set(newValue, forKey: .tokenType) }
    }
}

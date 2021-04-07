//
//  APIRequestAdapterDataSource.swift
//  ZConcept
//
//  Created by Alexey Papin on 26/10/2019.
//  Copyright © 2019 Alexey Papin. All rights reserved.
//

import Foundation

final class APIRequestAdapterDataSource: HTTPRequestAdapterDataSource {
    // Dependencies
    
    private let credentials: ICredentials
    private let infoProvider: IInfoProvider
    
    // MARK: - Init
    
    init(credentials: ICredentials, infoProvider: IInfoProvider) {
        self.credentials = credentials
        self.infoProvider = infoProvider
    }
    
    // MARK: - HTTPRequestAdapterDataSource
    
    func hostUrl() -> URL {
        return URL(string: infoProvider.apiHostUrl)!
    }
    
    func valueForHTTPHeaderKey(_ key: String) -> String? {
        switch key {
        case HTTPRequestHeaders.authorizationKey:
            let value = [credentials.tokenType, credentials.accessToken].compactMap { $0 }.joined(separator: " ")
            return value
            
        case HTTPRequestHeaders.accessTokenKey:
            let value = [credentials.tokenType, credentials.accessToken].compactMap { $0 }.joined(separator: " ")
            return value
            
        default: return nil
        }
    }
}

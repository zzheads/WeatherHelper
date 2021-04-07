//
//  HTTPRequestAdapter.swift
//  ZConcept
//
//  Created by Alexey Papin on 26/10/2019.
//  Copyright © 2019 Alexey Papin. All rights reserved.
//

import Alamofire

enum HTTPRequestAdapterError: Error {
    case noUrl(String)
    case noHost(String)
}

protocol HTTPRequestAdapterDataSource: AnyObject {
    func hostUrl() -> URL
    func valueForHTTPHeaderKey(_ key: String) -> String?
}

protocol IHTTPRequestInterceptor: Alamofire.RequestInterceptor {
    var dataSource: HTTPRequestAdapterDataSource? { get set }
}

final class HTTPRequestInterceptor: IHTTPRequestInterceptor {    
    weak var dataSource: HTTPRequestAdapterDataSource?

    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        var mutableRequest = urlRequest
        
        guard let url = mutableRequest.url else {
            completion(.failure(HTTPRequestAdapterError.noUrl("No url in \(mutableRequest)")))
            return
        }
        
        guard let hostUrl = dataSource?.hostUrl() else {
            completion(.failure(HTTPRequestAdapterError.noHost("Data source must provide host url")))
            return 
        }
        
        mutableRequest.url = URL(string: url.absoluteString, relativeTo: hostUrl)
        
        if let allHTTPHeaderFields = urlRequest.allHTTPHeaderFields {
            for (key, _) in allHTTPHeaderFields {
                guard let value = dataSource?.valueForHTTPHeaderKey(key) else {
                    continue
                }
                mutableRequest.setValue(value, forHTTPHeaderField: key)
            }
        }

        completion(.success(mutableRequest))
    }
}

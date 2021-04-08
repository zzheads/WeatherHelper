//
//  HTTPRequestAdapter.swift
//  ZConcept
//
//  Created by Alexey Papin on 26/10/2019.
//  Copyright © 2019 Alexey Papin. All rights reserved.
//

import Alamofire

enum HTTPRequestInterceptorError: Error {
    case missedValues([HTTPRequestInterceptor.Key])
}

protocol IHTTPRequestInterceptor: AnyObject {
    func adapt(_ urlRequest: inout URLRequest)
}

final class HTTPRequestInterceptor {
    enum Key: String, StringRawValueable {
        case key
        case accessKey
        case baseAbsoluteString
        case headers
    }

    let accessKey: String
    let baseAbsoluteString: String
    let headers: [String: String]

    var accessQueryItem: URLQueryItem { URLQueryItem(name: Key.key.rawValue, value: accessKey) }

    init(provider: ProvidesPlist) throws {
        let missedKeys: [Key] = [
            provider[Key.accessKey.rawValue] == nil ? .accessKey : nil,
            provider[Key.baseAbsoluteString.rawValue] == nil ? .baseAbsoluteString : nil,
            provider[Key.headers.rawValue] == nil ? .headers : nil
        ].compactMap { $0 }

        guard let accessKey = provider[Key.accessKey.rawValue] as? String,
              let baseAbsoluteString = provider[Key.baseAbsoluteString.rawValue] as? String,
              let headers = provider[Key.headers.rawValue] as? [String: String]
        else {
            throw HTTPRequestInterceptorError.missedValues(missedKeys)
        }

        self.accessKey = accessKey
        self.baseAbsoluteString = baseAbsoluteString
        self.headers = headers
    }
}

extension HTTPRequestInterceptor: IHTTPRequestInterceptor {
    func adapt(_ urlRequest: inout URLRequest) {
        add(queryItem: accessQueryItem, toRequest: &urlRequest, baseAbsoluteString: baseAbsoluteString)
        add(headers: headers, toRequest: &urlRequest)
    }

    private func add(queryItem: URLQueryItem, toRequest request: inout URLRequest, baseAbsoluteString: String) {
        guard let url = request.url else { return }
        var components = URLComponents(url: url, resolvingAgainstBaseURL: false)
        var items = components?.queryItems ?? []
        items.append(queryItem)
        components?.queryItems = items
        let fullPath = [baseAbsoluteString, components?.string].compactMap { $0 }.joined()
        request.url = URL(string: fullPath)
    }

    private func add(headers: [String: String], toRequest request: inout URLRequest) {
        headers.forEach { request.setValue($1, forHTTPHeaderField: $0) }
    }
}

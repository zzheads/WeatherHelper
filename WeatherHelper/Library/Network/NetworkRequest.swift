//
//  NetworkRequest.swift
//  ZConcept
//
//  Created by Alexey Papin on 26/10/2019.
//  Copyright © 2019 Alexey Papin. All rights reserved.
//

import Alamofire

protocol NetworkRequest: URLRequestConvertible {
    var endpoint: HTTPRequestEndpoint { get }
    var requestMethod: HTTPRequestMethod { get }
    var parameters: HTTPRequestParameters { get }
    var headers: HTTPRequestHeaders { get }
    var cachePolicy: NSURLRequest.CachePolicy { get }
    var needAuthorization: Bool { get }
}

extension NetworkRequest {
    var headers: HTTPRequestHeaders { .allHeaders }
    var cachePolicy: NSURLRequest.CachePolicy { .useProtocolCachePolicy }
    var needAuthorization: Bool { true }
}

extension NetworkRequest {
    func asURLRequest() throws -> URLRequest {
        guard let url = URL(string: endpoint.path) else {
            throw URLConvertibleError.failedToBuildPath
        }
        
        let httpMethod = Alamofire.HTTPMethod(httpRequestMethod: requestMethod)
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = httpMethod.rawValue
        urlRequest.cachePolicy = cachePolicy
        urlRequest = try encodeURLParameters(parameters.url, urlRequest: urlRequest)

        switch parameters.body {
        case .parameters(let parameters):
            urlRequest = try encodeJSONParameters(parameters, urlRequest: urlRequest)

        case .data(let data):
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            urlRequest.httpBody = data

        case .none:
            break
        }

        headers.forEach { urlRequest.setValue($1, forHTTPHeaderField: $0) }

        return urlRequest
    }
}

private extension NetworkRequest {
    func encodeURLParameters(_ parameters: Parameters?, urlRequest: URLRequest) throws -> URLRequest {
        guard let parameters = parameters else { return urlRequest }
        return try URLEncoding.queryString.encode(urlRequest, with: parameters)
    }

    func encodeJSONParameters(_ parameters: Parameters?, urlRequest: URLRequest) throws -> URLRequest {
        guard let parameters = parameters else { return urlRequest }
        return try JSONEncoding.default.encode(urlRequest, with: parameters)
    }
}

//
//  NetworkManager.swift
//  ZConcept
//
//  Created by Alexey Papin on 26/10/2019.
//  Copyright © 2019 Alexey Papin. All rights reserved.
//

import Alamofire

enum NetworkError: Error {
    case response(ResponseError)
    case adapter(Error)
    case connection
    case noHTTPResponse
    
    struct ResponseError {
        let code: Int
        let data: Data?
    }
}

protocol INetworkManager: AnyObject {
    typealias NetworkManagerCompletion = (_ result: Swift.Result<Data, NetworkError>) -> Void
    
    var requestInterceptor: IHTTPRequestInterceptor? { get set }
    func performRequest(_ request: URLRequestConvertible, completion: @escaping NetworkManagerCompletion)
    func httpResponse(_ request: URLRequestConvertible, completion: @escaping (Result<HTTPURLResponse, NetworkError>) -> Void)
}

final class NetworkManager: INetworkManager {
    
    var requestInterceptor: IHTTPRequestInterceptor?
    private let sessionConfiguration: URLSessionConfiguration
    private lazy var session: Alamofire.Session = {
        let session = Alamofire.Session(configuration: sessionConfiguration, interceptor: requestInterceptor)
        return session
    }()
    
    // MARK: - Init
    
    init(sessionConfiguration: URLSessionConfiguration, interceptor: IHTTPRequestInterceptor?) {
        self.sessionConfiguration = sessionConfiguration
        self.requestInterceptor = interceptor
    }
    
    // MARK: - INetworkManager
    
    func performRequest(_ request: URLRequestConvertible, completion: @escaping NetworkManagerCompletion) {
        print("Performing request: \(request.urlRequest?.description)")
        session.request(request).validate().responseData { dataResponse in
            switch dataResponse.result {
            case .success(let data):
                completion(.success(data))
                
            case .failure(let error):
                let networkError: NetworkError
                if error.isNoInternetConnection {
                    networkError = .connection
                } else {
                    let responseError = NetworkError.ResponseError(code: dataResponse.response?.statusCode ?? 0, data: dataResponse.data)
                    networkError = .response(responseError)
                }
                completion(.failure(networkError))
            }
        }
    }
    
    func httpResponse(_ request: URLRequestConvertible, completion: @escaping (Result<HTTPURLResponse, NetworkError>) -> Void) {
        session.request(request).validate().responseData {
            dataResponse in
            switch dataResponse.result {
            case .success(_):
                guard let response = dataResponse.response else {
                    completion(.failure(.noHTTPResponse))
                    return
                }
                completion(.success(response))
                
            case let .failure(error):
                let networkError: NetworkError
                if error.isNoInternetConnection {
                    networkError = .connection
                } else {
                    let responseError = NetworkError.ResponseError(code: dataResponse.response?.statusCode ?? 0, data: dataResponse.data)
                    networkError = .response(responseError)
                }
                completion(.failure(networkError))
            }
        }
    }
}

extension Error {
    var isNoInternetConnection: Bool {
        return (self as NSError).code == NSURLErrorNotConnectedToInternet
    }
}

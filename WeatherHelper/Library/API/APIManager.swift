//
//  APIManager.swift
//  ZConcept
//
//  Created by Alexey Papin on 26/10/2019.
//  Copyright © 2019 Alexey Papin. All rights reserved.
//

import Foundation

protocol IAPIManager: AnyObject {
    func performRequest(_ apiRequest: APIRequest, completion: @escaping (Result<Data, Error>) -> Void)
    func performRequest<T>(_ apiRequest: APIRequest, completion: @escaping (Result<T, Error>) -> Void) where T: Decodable
    func httpResponse(_ apiRequest: APIRequest, completion: @escaping (Result<HTTPURLResponse, NetworkError>) -> Void)
}

final class APIManager: IAPIManager {
        
    // Dependencies

    private let networkManager: INetworkManager
    private let adapterDataSource: HTTPRequestAdapterDataSource
    
    // MARK: - Init
    
    init(networkManager: INetworkManager, adapterDataSource: HTTPRequestAdapterDataSource) {
        self.networkManager = networkManager
        self.adapterDataSource = adapterDataSource
    }
    
    // MARK: - IAPIManager
    
    func performRequest(_ apiRequest: APIRequest, completion: @escaping (Result<Data, Error>) -> Void) {
        networkManager.performRequest(apiRequest) {
            result in
            
            switch result {
            case .failure(let networkError):
                completion(.failure(networkError))
            case .success(let data):
                completion(.success(data))
            }
        }
    }
    
    func performRequest<T>(_ apiRequest: APIRequest, completion: @escaping (Result<T, Error>) -> Void) where T: Decodable {
        performRequest(apiRequest) {
            result in
            
            switch result {
            case .failure(let networkError):
                completion(.failure(networkError))
                
            case .success(let data):
                do {
                    let response = try apiRequest.decoder.decode(T.self, from: data)
                    completion(.success(response))
                } catch let parsingError {
                    completion(.failure(parsingError))
                }
            }
        }
    }
    
    func httpResponse(_ apiRequest: APIRequest, completion: @escaping (Result<HTTPURLResponse, NetworkError>) -> Void) {
        networkManager.httpResponse(apiRequest, completion: completion)
    }
}

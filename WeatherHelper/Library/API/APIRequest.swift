//
//  APIRequest.swift
//  ZConcept
//
//  Created by Alexey Papin on 26/10/2019.
//  Copyright © 2019 Alexey Papin. All rights reserved.
//

import Foundation

protocol APIRequest: NetworkRequest {
    var decoder: JSONDecoder { get }
}

extension APIRequest {
    var decoder: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970
        return decoder
    }
}

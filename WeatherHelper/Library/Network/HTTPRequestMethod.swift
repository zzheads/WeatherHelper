//
//  HTTPRequestMethod.swift
//  ZConcept
//
//  Created by Alexey Papin on 26/10/2019.
//  Copyright © 2019 Alexey Papin. All rights reserved.
//

import Alamofire

enum HTTPRequestMethod: String {
    case get = "GET"
    case post = "POST"
    case delete = "DELETE"
    case patch = "PATCH"
    case put = "PUT"
}

extension Alamofire.HTTPMethod {
    init(httpRequestMethod: HTTPRequestMethod) {
        self = Alamofire.HTTPMethod(rawValue: httpRequestMethod.rawValue) 
    }
}

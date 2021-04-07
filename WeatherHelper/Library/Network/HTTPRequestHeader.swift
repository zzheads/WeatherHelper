//
//  HTTPRequestHeader.swift
//  ZConcept
//
//  Created by Alexey Papin on 26/10/2019.
//  Copyright © 2019 Alexey Papin. All rights reserved.
//

import Foundation

typealias HTTPRequestHeaders = [String: String]

extension HTTPRequestHeaders {
    static let authorizationKey = "Authorization"
    static let accessTokenKey = "access-token"
    static let allHeaders: HTTPRequestHeaders = [authorizationKey: "", accessTokenKey: ""]
}

//
//  URLRequestConvertible.swift
//  ZConcept
//
//  Created by Alexey Papin on 26/10/2019.
//  Copyright © 2019 Alexey Papin. All rights reserved.
//

import Alamofire

enum URLConvertibleError: Error {
    case failedToBuildPath
}

protocol URLRequestConvertible: Alamofire.URLRequestConvertible {}

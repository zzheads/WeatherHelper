//
//  HTTPRequestParameter.swift
//  ZConcept
//
//  Created by Alexey Papin on 26/10/2019.
//  Copyright © 2019 Alexey Papin. All rights reserved.
//

import Foundation

typealias Parameters = [String: Any]

struct HTTPRequestParameters {
    enum BodyParameters {
        case data(Data)
        case parameters(Parameters)
    }
    
    var body: BodyParameters?
    var url: Parameters?

    init(body: BodyParameters? = nil, url: Parameters? = nil) {
        self.body = body
        self.url = url
    }
}

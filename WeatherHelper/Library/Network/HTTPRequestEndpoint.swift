//
//  HTTPEndpoint.swift
//  zochat
//
//  Created by Алексей Папин on 27.06.2020.
//  Copyright © 2020 Алексей Папин. All rights reserved.
//

import Foundation

enum HTTPRequestEndpoint: String {
    static let baseURLString: String = "http://api.weatherstack.com/"
    
    case current
    case historical
    case forecast
    
    var path: String {
        [HTTPRequestEndpoint.baseURLString, rawValue].joined()
    }
}

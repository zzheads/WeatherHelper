//
//  HTTPEndpoint.swift
//  zochat
//
//  Created by Алексей Папин on 27.06.2020.
//  Copyright © 2020 Алексей Папин. All rights reserved.
//

import Foundation

enum HTTPRequestEndpoint: String {
    case current = "/current"
    case forecastDaily = "/forecast/daily"
    case forecastHourly = "/forecast/hourly"
    case forecastMinutely = "/forecast/minutely"

    var path: String { rawValue }
}

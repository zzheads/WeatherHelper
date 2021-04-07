//
//  WeatherRequest.swift
//  WeatherHelper
//
//  Created by Алексей Папин on 07.04.2021.
//

import Foundation
import CoreLocation

final class CurrentWeatherRequest: APIRequest {
    var endpoint: HTTPRequestEndpoint { .current }
    var requestMethod: HTTPRequestMethod { .get }
    var parameters: HTTPRequestParameters {
        var urlParameters: Parameters = location.parameter
        if let units = units {
            for (key, value) in units.parameter {
                urlParameters[key] = value
            }
        }
        return HTTPRequestParameters(url: urlParameters)
    }

    private let location: Location
    private let units: Units?

    init(location: Location = .autoFetch, units: Units? = nil) {
        self.location = location
        self.units = units
    }
}

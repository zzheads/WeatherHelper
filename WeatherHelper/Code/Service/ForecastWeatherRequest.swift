//
//  ForecastWeatherRequest.swift
//  WeatherHelper
//
//  Created by Алексей Папин on 08.04.2021.
//

import Foundation

final class ForecastWeatherRequest: APIRequest {
    var endpoint: HTTPRequestEndpoint { .forecast }
    var requestMethod: HTTPRequestMethod { .get }

    var parameters: HTTPRequestParameters {
        var urlParameters = location.parameter
        for param in params {
            for (key, value) in param.parameter {
                urlParameters.updateValue(value, forKey: key)
            }
        }
        if let units = units {
            for (key, value) in units.parameter {
                urlParameters.updateValue(value, forKey: key)
            }
        }
        return HTTPRequestParameters(body: nil, url: urlParameters)
    }

    private let location: Location
    private let params: [ForecastParam]
    private let units: Units?

    init(location: Location, params: [ForecastParam] = [], units: Units? = nil) {
        self.location = location
        self.params = params
        self.units = units
    }
}

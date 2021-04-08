//
//  CurrentWeatherRequest.swift
//  WeatherHelper
//
//  Created by Алексей Папин on 08.04.2021.
//

import Foundation

final class CurrentWeatherRequest: APIRequest {
    var endpoint: HTTPRequestEndpoint { .current }
    var requestMethod: HTTPRequestMethod { .get }
    var parameters: HTTPRequestParameters

    init(_ parameters: [RequestParameter]) {
        self.parameters = HTTPRequestParameters(url: RequestParameter.parameters(parameters))
    }
}

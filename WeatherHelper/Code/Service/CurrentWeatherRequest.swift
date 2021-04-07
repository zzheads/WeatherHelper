//
//  WeatherRequest.swift
//  WeatherHelper
//
//  Created by Алексей Папин on 07.04.2021.
//

import Foundation
import CoreLocation

final class CurrentWeatherRequest: APIRequest {
    enum Location {
        static let key = "query"

        case cities([String])
        case zipCode(String)
        case coordinate(CLLocationCoordinate2D)
        case ip(String)
        case autoFetch

        var query: String {
            switch self {
            case .autoFetch: return "fetch:ip"
            case let .cities(cities): return cities.map { $0 }.joined(separator: ",")
            case let .coordinate(coordinate): return [coordinate.latitude.description, coordinate.longitude.description].joined(separator: ",")
            case let .ip(ip): return ip
            case let .zipCode(zipCode): return zipCode
            }
        }

        var parameter: Parameters { [Location.key: query] }
    }

    enum Units: String {
        static let key = "units"

        case metric = "m"
        case scientific = "s"
        case fahrenheit = "f"

        var parameter: Parameters { [Units.key: rawValue] }
    }

    var endpoint: HTTPRequestEndpoint { .current }
    var requestMethod: HTTPRequestMethod { .get }

    let location: Location?
    let units: Units?

    var parameters: HTTPRequestParameters? {
        var urlParameters: Parameters = accessTokenDict
        if let location = location {
            for (key, value) in location.parameter {
                urlParameters[key] = value
            }
        }
        if let units = units {
            for (key, value) in units.parameter {
                urlParameters[key] = value
            }
        }
        return HTTPRequestParameters(url: urlParameters)
    }

    init(location: Location? = nil, units: Units? = nil) {
        self.location = location
        self.units = units
    }
}

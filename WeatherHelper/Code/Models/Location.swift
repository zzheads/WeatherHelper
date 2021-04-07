//
//  Location.swift
//  WeatherHelper
//
//  Created by Алексей Папин on 08.04.2021.
//

import CoreLocation

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

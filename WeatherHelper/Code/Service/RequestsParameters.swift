//
//  RequestsParameters.swift
//  WeatherHelper
//
//  Created by Алексей Папин on 08.04.2021.
//

import Foundation
import CoreLocation

enum RequestParameter {
    enum Key: String, StringRawValueable {
        case units
        case days
        case hours
        case language
        case lat
        case lon
    }

    enum Units: String {
        case metric
        case scientific
        case fahrenheit

        var value: String { String(rawValue.first!) }

        var degrees: String {
            switch self {
            case .metric: return "°C"
            case .scientific: return "°K"
            case .fahrenheit: return "°F"
            }
        }

        var speed: String {
            switch self {
            case .metric, .scientific: return "m/s"
            case .fahrenheit: return "mph"
            }
        }

        var height: String {
            switch self {
            case .metric, .scientific: return "mm"
            case .fahrenheit: return "in"
            }
        }
    }

    case units(Units)
    case days(UInt)
    case hours(UInt)
    case language(String)
    case latitude(CLLocationDegrees)
    case longitude(CLLocationDegrees)

    var key: Key {
        switch self {
        case .units: return .units
        case .days: return .days
        case .hours: return .hours
        case .language: return .language
        case .latitude: return .lat
        case .longitude: return .lon
        }
    }

    var value: String {
        switch self {
        case let .units(units): return units.value
        case let .days(days): return days.description
        case let .hours(hours): return hours.description
        case let .language(language): return language
        case let .latitude(lat): return lat.description
        case let .longitude(lon): return lon.description
        }
    }

    var parameter: [String: String] { [key.rawValue: value] }

    static func parameters(_ params: [RequestParameter]) -> Parameters {
        Dictionary(uniqueKeysWithValues: params.map { ($0.key.rawValue, $0.value) })
    }
}

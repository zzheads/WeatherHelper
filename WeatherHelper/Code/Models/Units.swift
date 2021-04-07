//
//  Units.swift
//  WeatherHelper
//
//  Created by Алексей Папин on 08.04.2021.
//

import Foundation

enum Units: String, Codable {
    static let key = "units"

    case metric = "m"
    case scientific = "s"
    case fahrenheit = "f"

    var parameter: Parameters { [Units.key: rawValue] }

    var sign: (temperature: String, windSpeed: String, pressure: String, precip: String, snow: String) {
        switch self {
        case .metric:
            return (temperature: "°C", windSpeed: "km/h", pressure: "mb", precip: "mm", snow: "cm")
        case .fahrenheit:
            return (temperature: "°F", windSpeed: "miles/h", pressure: "mb", precip: "in", snow: "in")
        case .scientific:
            return (temperature: "°K", windSpeed: "km/h", pressure: "mb", precip: "mm", snow: "cm")
        }
    }
}

//
//  CurrentWeatherResponse.swift
//  WeatherHelper
//
//  Created by Алексей Папин on 07.04.2021.
//

import Foundation
import CoreLocation

final class CurrentWeatherResponse: Codable {
    struct Request: Codable {
        let type: String
        let query: String
        let language: String
        let unit: CurrentWeatherRequest.Units
    }

    struct Location: Codable {
        let name: String
        let country: String
        let region: String
        let lat: String
        let lon: String
        let timezone_id: String
        let localtime: String
        let localtime_epoch: TimeInterval
        let utc_offset: String

        var description: String {
            [name, region, country].joined(separator: ", ")
        }
    }

    struct Current: Codable {
        let observation_time: String
        let temperature: Double
        let weather_code: Int
        let weather_icons: [String]
        let weather_descriptions: [String]
        let wind_speed: Double
        let wind_degree: Double
        let wind_dir: String
        let pressure: Int
        let precip: Double
        let humidity: Int
        let cloudcover: Int
        let feelslike: Double
        let uv_index: Int
        let visibility: Int
    }

    let request: Request
    let location: Location
    let current: Current

    var temperatureWithSign: String {
        [current.temperature.description, request.unit.sign.temperature].joined()
    }

    private enum CodingKeys: String, CodingKey {
        case request
        case location
        case current
    }
}

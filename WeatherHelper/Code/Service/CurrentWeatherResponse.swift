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
        let unit: String
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
        let precip: Int
        let humidity: Int
        let cloudcover: Int
        let feelslike: Double
        let uv_index: Int
        let visibility: Int
    }

    let request: Request
    let location: Location
    let current: Current

    private enum CodingKeys: String, CodingKey {
        case request
        case location
        case current
    }
}

//
//  CurrentWeatherResponse.swift
//  WeatherHelper
//
//  Created by Алексей Папин on 08.04.2021.
//

import CoreLocation

final class CurrentWeatherResponse: Codable {
    struct Data: Codable {
        struct Weather: Codable {
            let icon: String
            let code: UInt
            let description: String
        }

        let wind_cdir: String
        let rh: UInt
        let pod: String
        let lon: CLLocationDegrees
        let pres: Double
        let timezone: String
        let ob_time: String
        let country_code: String
        let clouds: UInt
        let vis: UInt
        let wind_spd: Double
        let wind_cdir_full: String
        let app_temp: Double
        let state_code: String
        let ts: TimeInterval
        let h_angle: Double
        let dewpt: Double
        let weather: Weather
        let uv: Double
        let aqi: UInt
        let station: String
        let wind_dir: UInt
        let elev_angle: Double
        let datetime: String
        let precip: Double
        let ghi: Double
        let dni: Double
        let dhi: Double
        let solar_rad: Double
        let city_name: String
        let sunrise: String
        let sunset: String
        let temp: Double
        let lat: CLLocationDegrees
        let slp: Double

        var location: String {
            [city_name, country_code, "(lat: \(lat), lon: \(lon))"].joined(separator: ", ")
        }

        func temperature(units: WeatherRequest.Parameter.Units) -> String {
            [temp.description, units.degrees].joined()
        }
    }

    let data: [Data]
    let count: UInt
}

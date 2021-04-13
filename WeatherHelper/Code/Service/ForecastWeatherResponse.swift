//
//  ForecastWeatherResponse.swift
//  WeatherHelper
//
//  Created by Алексей Папин on 09.04.2021.
//

import CoreLocation

final class ForecastWeatherResponse: Codable {
    struct Data: Codable {
        struct Weather: Codable {
            let icon: String
            let code: UInt
            let description: String
        }

        let valid_date: String
        let ts: TimeInterval
        let datetime: String
        let wind_gust_spd: Double
        let wind_spd: Double
        let wind_dir: Double
        let wind_cdir: String
        let wind_cdir_full: String
        let temp: Double
        let max_temp: Double
        let min_temp: Double
        let high_temp: Double
        let low_temp: Double
        let app_max_temp: Double
        let app_min_temp: Double
        let pop: Double
        let precip: Double
        let snow: Double
        let snow_depth: Double
        let slp: Double
        let pres: Double
        let dewpt: Double
        let rh: Double
        let weather: Weather
        let pod: String?
        let clouds_low: Double
        let clouds_mid: Double
        let clouds_hi: Double
        let clouds: Double
        let vis: Double
        let max_dhi: Double?
        let uv: Double
        let moon_phase: Double
        let moon_phase_lunation: Double
        let moonrise_ts: TimeInterval
        let moonset_ts: TimeInterval
        let sunrise_ts: TimeInterval
        let sunset_ts: TimeInterval
    }

    let data: [Data]
    let city_name: String
    let lon: String
    let timezone: String
    let lat: String
    let country_code: String
    let state_code: String
}

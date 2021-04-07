//
//  ForecastParam.swift
//  WeatherHelper
//
//  Created by Алексей Папин on 08.04.2021.
//

import Foundation

enum ForecastParam {
    private enum Key: String {
        case forecast_days
        case hourly
        case interval
    }

    enum Interval: Int {
        case _1 = 1
        case _3 = 3
        case _6 = 6
        case _12 = 12
        case _24 = 24
    }

    case days(Int)
    case hourly(Bool)
    case interval(Interval)

    var key: String {
        switch self {
        case .days: return Key.forecast_days.rawValue
        case .hourly: return Key.hourly.rawValue
        case .interval: return Key.interval.rawValue
        }
    }

    var value: Int {
        switch self {
        case let .days(days):
            return days
        case let .hourly(hourly):
            return hourly ? 1 : 0
        case let .interval(interval):
            return interval.rawValue
        }
    }

    var parameter: Parameters { [key: value] }
}

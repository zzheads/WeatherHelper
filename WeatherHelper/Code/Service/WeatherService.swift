//
//  WeatherService.swift
//  WeatherHelper
//
//  Created by Алексей Папин on 07.04.2021.
//

import Foundation

protocol WeatherServiceProtocol: AnyObject {
}

final class WeatherService {
    let manager: APIManager

    init(manager: APIManager) {
        self.manager = manager
    }

    func getCurrentWeather(completion: @escaping ((Result<CurrentWeatherResponse, Error>) -> Void)) {
        let request = CurrentWeatherRequest(location: .autoFetch, units: .metric)
        manager.performRequest(request, completion: completion)
    }
}

//
//  WeatherService.swift
//  WeatherHelper
//
//  Created by Алексей Папин on 08.04.2021.
//

import Foundation

protocol IWeatherService: AnyObject {
    func fetchCurrent(_ parameters: [WeatherRequest.Parameter], completion: @escaping ((Result<CurrentWeatherResponse, Error>) -> Void))
    func fetchForecastDaily(_ parameters: [WeatherRequest.Parameter], completion: @escaping ((Result<ForecastWeatherResponse, Error>) -> Void))
}

final class WeatherService {
    private let manager: IAPIManager

    init(manager: IAPIManager) {
        self.manager = manager
    }
}

extension WeatherService: IWeatherService {
    func fetchCurrent(_ parameters: [WeatherRequest.Parameter], completion: @escaping ((Result<CurrentWeatherResponse, Error>) -> Void)) {
        let request = WeatherRequest(.current, parameters: parameters)
        manager.performRequest(request, completion: completion)
    }

    func fetchForecastDaily(_ parameters: [WeatherRequest.Parameter], completion: @escaping ((Result<ForecastWeatherResponse, Error>) -> Void)) {
        let request = WeatherRequest(.forecastDaily, parameters: parameters)
        manager.performRequest(request, completion: completion)
    }
}

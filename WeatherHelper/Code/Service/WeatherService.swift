//
//  WeatherService.swift
//  WeatherHelper
//
//  Created by Алексей Папин on 08.04.2021.
//

import Foundation

protocol IWeatherService: AnyObject {
    func fetchCurrent(_ parameters: [RequestParameter], completion: @escaping ((Result<CurrentWeatherResponse, Error>) -> Void))
}

final class WeatherService {
    private let manager: IAPIManager

    init(manager: IAPIManager) {
        self.manager = manager
    }
}

extension WeatherService: IWeatherService {
    func fetchCurrent(_ parameters: [RequestParameter], completion: @escaping ((Result<CurrentWeatherResponse, Error>) -> Void)) {
        manager.performRequest(CurrentWeatherRequest(parameters), completion: completion)
    }
}

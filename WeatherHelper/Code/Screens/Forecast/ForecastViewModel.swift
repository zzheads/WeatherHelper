//
//  ForecastViewModel.swift
//  WeatherHelper
//
//  Created by Алексей Папин on 07.04.2021.
//

import Foundation

final class ForecastViewModel: BaseViewModel {
    private let dependenciesProvider = DependenciesProvider()
    private lazy var plistProvider: ProvidesPlist = dependenciesProvider.resolve(ProvidesPlist.self)!
    private lazy var service: IWeatherService = dependenciesProvider.resolve(IWeatherService.self)!

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        service.fetchForecastDaily([.latitude(38), .longitude(-78.25)]) {
            result in
            switch result {
            case let .success(response):
                print(response)
            case let .failure(error):
                print(error)
            }
        }
    }
}

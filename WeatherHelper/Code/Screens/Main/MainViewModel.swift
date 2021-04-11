//
//  MainViewModel.swift
//  WeatherHelper
//
//  Created by Алексей Папин on 06.04.2021.
//

import UIKit
import Swinject
import CoreLocation

final class MainViewModel: BaseViewModel {
    private enum Constants {
        static let units: WeatherRequest.Parameter.Units = .metric
    }

    enum ViewState {
        case loading
        case loaded(Result<CurrentWeatherResponse, Error>)
    }

    private let dependenciesProvider = DependenciesProvider()
    private lazy var mapper: MappingWeather = dependenciesProvider.resolve(MappingWeather.self)!
    private lazy var service: IWeatherService = dependenciesProvider.resolve(IWeatherService.self)!
    private lazy var locationProvider: ProvidesLocation = dependenciesProvider.resolve(ProvidesLocation.self)!

    var updateViewState: ((ViewState) -> Void)?

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateViewState?(.loading)

        service.fetchCurrent([.latitude(38), .longitude(-78.25), .units(Constants.units)]) {
            [weak self] result in
            self?.updateViewState?(.loaded(result))
        }
    }

    func temperature(temp: Double?) -> String? {
        guard let temp = temp else { return nil }
        return mapper.temperature(temp, units: Constants.units)
    }

    func iconURL(icon: String) -> URL? {
        mapper.iconURL(icon: icon)        
    }
}

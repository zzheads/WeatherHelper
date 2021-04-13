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

    private let mapper: MappingWeather = DependenciesProvider.shared.resolve(MappingWeather.self)!
    private let service: IWeatherService = DependenciesProvider.shared.resolve(IWeatherService.self)!
    private weak var locationProvider = DependenciesProvider.shared.resolve(ProvidesLocation.self)
    private let defaultMethod = DependenciesProvider.shared.resolve(LocationMethod.self)!

    var subscribeViews: ((ProvidesLocation?) -> Void)?
    var unsubscribeViews: ((ProvidesLocation?) -> Void)?
    var updateViewState: ((ViewState) -> Void)?

    deinit {
        unsubscribeViews?(locationProvider)
        locationProvider?.removeObserver(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        update(withLocationMethod: defaultMethod)
    }
    
    override func didBindUIWithViewModel() {
        super.didBindUIWithViewModel()
        locationProvider?.addObserver(self)
        subscribeViews?(locationProvider)
    }
    
    func temperature(temp: Double?) -> String? {
        guard let temp = temp else { return nil }
        return mapper.temperature(temp, units: Constants.units)
    }

    func iconURL(icon: String) -> URL? {
        mapper.iconURL(icon: icon)        
    }
    
    private func update(withLocationMethod method: LocationMethod) {
        guard var parameters = method.parameters else {
            // TODO: handle bad method
            return
        }
        parameters.append(.units(Constants.units))
        updateViewState?(.loading)
        service.fetchCurrent(parameters) {
            [weak self] result in
            self?.updateViewState?(.loaded(result))
        }
    }
}

extension MainViewModel: LocationObserver {
    func locationDidChange(_ newMethod: LocationMethod) {
        update(withLocationMethod: newMethod)
    }
}

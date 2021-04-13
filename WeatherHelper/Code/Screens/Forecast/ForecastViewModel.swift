//
//  ForecastViewModel.swift
//  WeatherHelper
//
//  Created by Алексей Папин on 07.04.2021.
//

import Foundation

final class ForecastViewModel: BaseViewModel {
    private enum Constants {
        static let defaultCity = "Volgograd"
        static let units: WeatherRequest.Parameter.Units = .metric
    }

    enum ViewState {
        case loading
        case loaded
    }

    private let mapper: MappingWeather = DependenciesProvider.shared.resolve(MappingWeather.self)!
    private let service: IWeatherService = DependenciesProvider.shared.resolve(IWeatherService.self)!
    private weak var locationProvider = DependenciesProvider.shared.resolve(ProvidesLocation.self)
    private let defaultMethod = DependenciesProvider.shared.resolve(LocationMethod.self)!

    var models: [ForecastWeatherCell.ViewModel] = []

    var updateViewState: ((ViewState) -> Void)?
    var subscribeViews: ((ProvidesLocation?) -> Void)?
    var unsubscribeViews: ((ProvidesLocation?) -> Void)?

    override init() {
        super.init()
        locationProvider?.addObserver(self)
    }
    
    deinit {
        unsubscribeViews?(locationProvider)
        locationProvider?.removeObserver(self)
    }
    
    override func didBindUIWithViewModel() {
        super.didBindUIWithViewModel()
        subscribeViews?(locationProvider)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        update(withLocationMethod: defaultMethod)
    }
    
    private func update(withLocationMethod method: LocationMethod) {
        guard var parameters = method.parameters else {
            // TODO: handle bad method
            return
        }
        parameters.append(.units(Constants.units))
        updateViewState?(.loading)
        service.fetchForecastDaily(parameters) {
            [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(response):
                self.models = response.data.map { self.mapper.cellModel(data: $0, style: .medium(date: .right, temp: .left)) }

            case let .failure(error):
                print(error)
            }
            self.updateViewState?(.loaded)
        }
    }
}

extension ForecastViewModel: LocationObserver {
    func locationDidChange(_ newMethod: LocationMethod) {
        update(withLocationMethod: newMethod)
    }
}

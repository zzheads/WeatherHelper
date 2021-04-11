//
//  ForecastViewModel.swift
//  WeatherHelper
//
//  Created by Алексей Папин on 07.04.2021.
//

import Foundation

final class ForecastViewModel: BaseViewModel {
    enum ViewState {
        case loading
        case loaded
    }

    private let dependenciesProvider = DependenciesProvider()
    private lazy var mapper: MappingWeather = dependenciesProvider.resolve(MappingWeather.self)!
    private lazy var service: IWeatherService = dependenciesProvider.resolve(IWeatherService.self)!

    var models: [ForecastWeatherCell.ViewModel] = []

    var updateViewState: ((ViewState) -> Void)?

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateViewState?(.loading)
        service.fetchForecastDaily([.latitude(38), .longitude(-78.25)]) {
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

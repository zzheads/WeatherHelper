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

    private let mapper: MappingWeather = DependenciesProvider.shared.resolve(MappingWeather.self)!
    private let service: IWeatherService = DependenciesProvider.shared.resolve(IWeatherService.self)!

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

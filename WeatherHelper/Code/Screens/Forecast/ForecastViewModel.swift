//
//  ForecastViewModel.swift
//  WeatherHelper
//
//  Created by Алексей Папин on 07.04.2021.
//

import Foundation

final class ForecastViewModel: BaseViewModel {
    private let dependenciesProvider = DependenciesProvider()
    private lazy var mapper: MappingWeather = dependenciesProvider.resolve(MappingWeather.self)!
    private lazy var service: IWeatherService = dependenciesProvider.resolve(IWeatherService.self)!

    var models: [ForecastWeatherCell.ViewModel] = []

    var reloadTableView: (() -> Void)?

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        service.fetchForecastDaily([.latitude(38), .longitude(-78.25)]) {
            [weak self] result in
            switch result {
            case let .success(response):
                self?.update(response: response)
                
            case let .failure(error):
                print(error)
            }
        }
    }

    private func update(response: ForecastWeatherResponse) {
        models = response.data.map { mapper.cellModel(data: $0) }
        reloadTableView?()
    }
}

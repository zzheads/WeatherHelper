//
//  MainViewModel.swift
//  WeatherHelper
//
//  Created by Алексей Папин on 06.04.2021.
//

import UIKit

final class MainViewModel: BaseViewModel {
    enum ViewState {
        case loading
        case loaded(Result<CurrentWeatherResponse, Error>)
    }

    var updateViewState: ((ViewState) -> Void)?

    private lazy var service: WeatherService = {
        let networkManager = NetworkManager(sessionConfiguration: .default, interceptor: nil)
        let manager = APIManager(networkManager: networkManager, adapterDataSource: self)
        return WeatherService(manager: manager)
    }()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateViewState?(.loading)
        service.getCurrentWeather {
            [weak self] result in
            self?.updateViewState?(.loaded(result))
        }
    }
}

extension MainViewModel: HTTPRequestAdapterDataSource {
    func hostUrl() -> URL {
        URL(string: HTTPRequestEndpoint.baseURLString)!
    }

    func valueForHTTPHeaderKey(_ key: String) -> String? {
        nil
    }
}

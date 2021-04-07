//
//  MainViewModel.swift
//  WeatherHelper
//
//  Created by Алексей Папин on 06.04.2021.
//

import UIKit

final class MainViewModel: BaseViewModel {
    private lazy var service: WeatherService = {
        let networkManager = NetworkManager(sessionConfiguration: .default, interceptor: nil)
        let manager = APIManager(networkManager: networkManager, adapterDataSource: self)
        return WeatherService(manager: manager)
    }()

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        service.getCurrentWeather {
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

extension MainViewModel: HTTPRequestAdapterDataSource {
    func hostUrl() -> URL {
        URL(string: HTTPRequestEndpoint.baseURLString)!
    }

    func valueForHTTPHeaderKey(_ key: String) -> String? {
        nil
    }
}

//
//  APIAssembly.swift
//  WeatherHelper
//
//  Created by Алексей Папин on 08.04.2021.
//

import Swinject

final class APIAssembly: Assembly {
    private enum Constants {
        static let plistFileName = "APIConfig"
    }

    func assemble(container: Container) {
        container.register(ProvidesPlist.self) { _ in
            PlistProvider(fileName: Constants.plistFileName)!
        }.inObjectScope(.container)

        container.register(IHTTPRequestInterceptor.self) {
            try! HTTPRequestInterceptor(
                provider: $0.resolve(ProvidesPlist.self)!
            )
        }.inObjectScope(.container)

        container.register(INetworkManager.self) {
            NetworkManager(
                sessionConfiguration: .default,
                interceptor: $0.resolve(IHTTPRequestInterceptor.self)!
            )
        }.inObjectScope(.container)

        container.register(IAPIManager.self) {
            APIManager(
                networkManager: $0.resolve(INetworkManager.self)!
            )
        }.inObjectScope(.container)

        container.register(IWeatherService.self) {
            WeatherService(
                manager: $0.resolve(IAPIManager.self)!
            )
        }.inObjectScope(.container)
    }
}

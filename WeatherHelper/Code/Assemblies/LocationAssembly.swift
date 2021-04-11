//
//  LocationAssmbly.swift
//  WeatherHelper
//
//  Created by Алексей Папин on 11.04.2021.
//

import Swinject

final class LocationAssembly: Assembly {
    func assemble(container: Container) {
        container.register(ProvidesLocation.self) {
            _ in LocationViewModel()
        }
    }
}

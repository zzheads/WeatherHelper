//
//  LocationAssmbly.swift
//  WeatherHelper
//
//  Created by Алексей Папин on 11.04.2021.
//

import CoreLocation
import Swinject

final class LocationAssembly: Assembly {
    func assemble(container: Container) {
        container.register(LocationMethod.self) {
            _ in .updating(status: .notDetermined, coordinate: nil)
        }
        
        container.register(LocationViewModel.LocationKind.self) {
            _ in .location
        }
        
        container.register(ProvidesLocation.self) {
            resolver in LocationViewModel(locationKind: resolver.resolve(LocationViewModel.LocationKind.self)!)
        }.inObjectScope(.container)
        
    }
}

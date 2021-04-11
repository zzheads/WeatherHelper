//
//  DependenciesProvider.swift
//  WeatherHelper
//
//  Created by Алексей Папин on 08.04.2021.
//

import Swinject

final class DependenciesProvider {
    private let container: Container
    private let assembler: Assembler

    init() {
        self.container = Container()
        self.assembler = Assembler(
            [
                APIAssembly(),
                LocationAssembly()
            ],
            container: container
        )
    }

    public func resolve<T>(_ serviceType: T.Type) -> T? {
        container.resolve(serviceType)
    }
}

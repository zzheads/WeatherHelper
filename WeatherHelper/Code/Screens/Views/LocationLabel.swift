//
//  LocationView.swift
//  WeatherHelper
//
//  Created by Алексей Папин on 13.04.2021.
//

import UIKit

final class LocationLabel: UILabel {
}

extension LocationLabel: LocationObserver {
    func locationDidChange(_ newMethod: LocationMethod) {
        switch newMethod {
        case let .updating(status, coordinate):
            text = "Updating: (status - \(status)), coordinate: \(coordinate?.latitude.description ?? "-");\(coordinate?.longitude.description ?? "-")"
        case let .setCoordinate(coordinate):
            text = "Set coordinate: \(coordinate?.latitude.description ?? "-");\(coordinate?.longitude.description ?? "-")"
        case let .setCity(city):
            text = "Set city: \(city ?? "-")"
        }
    }
}

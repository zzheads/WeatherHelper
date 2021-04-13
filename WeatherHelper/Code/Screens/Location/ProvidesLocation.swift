//
//  LocationManager.swift
//  WeatherHelper
//
//  Created by Алексей Папин on 11.04.2021.
//

import CoreLocation

extension CLAuthorizationStatus: CustomStringConvertible {
    public var description: String {
        switch self {
        case .authorizedAlways:
            return "authorizedAlways"
        case .authorizedWhenInUse:
            return "authorizedWhenInUse"
        case .denied:
            return "denied"
        case .notDetermined:
            return ""
        case .restricted:
            return "notDetermined"
        default:
            return "unknown"
        }
    }
}

enum LocationMethod {
    case updating(status: CLAuthorizationStatus, coordinate: CLLocationCoordinate2D?)
    case setCity(String?)
    case setCoordinate(CLLocationCoordinate2D?)

    var parameters: [WeatherRequest.Parameter]? {
        switch self {
        case let .updating(_, coordinate):
            guard let coordinate = coordinate else { return nil }
            return [.latitude(coordinate.latitude), .longitude(coordinate.longitude)]
        case let .setCoordinate(coordinate):
            guard let coordinate = coordinate else { return nil }
            return [.latitude(coordinate.latitude), .longitude(coordinate.longitude)]
        case let .setCity(city):
            guard let city = city else { return nil }
            return [.city(city)]
        }
    }
}

protocol ProvidesLocation: AnyObject {
    func addObserver(_ observer: LocationObserver)
    func removeObserver(_ observer: LocationObserver)
}

protocol LocationObserver: AnyObject {
    func locationDidChange(_ newMethod: LocationMethod)
}

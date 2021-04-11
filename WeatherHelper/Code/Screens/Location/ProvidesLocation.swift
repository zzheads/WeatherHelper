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

protocol ProvidesLocation: AnyObject {
    func addObserver(_ observer: LocationObserver)
    func removeObserver(_ observer: LocationObserver)
}

protocol LocationObserver: AnyObject {
}

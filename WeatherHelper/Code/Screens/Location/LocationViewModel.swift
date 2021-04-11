//
//  LocationViewModel.swift
//  WeatherHelper
//
//  Created by Алексей Папин on 11.04.2021.
//

import CoreLocation
import UIKit

final class LocationViewModel: BaseViewModel {
    enum LocationKind: CaseIterable {
        static var allCases: [LocationKind] = [
            .location(nil),
            .city(nil),
            .coordinate(nil)
        ]

        case location(CLLocationCoordinate2D?)
        case city(String?)
        case coordinate(CLLocationCoordinate2D?)

        var title: String {
            switch self {
            case .location: return "Location"
            case .city: return "City"
            case .coordinate: return "Coordinate"
            }
        }
    }

    var selectSegment: ((Int) -> Void)?

    var items: [String] = LocationKind.allCases.map { $0.title }

    private var observers: [LocationObserver] = []
    private var locationKind: LocationKind = .location(nil)
    private var selectedSegment: Int? { items.firstIndex(of: locationKind.title) }

    private lazy var locationManager: CLLocationManager = {
        let manager = CLLocationManager()
        manager.delegate = self
        return manager
    }()

    private var lastLocation: CLLocationCoordinate2D?

    override init() {
        super.init()
        locationManager.startUpdatingLocation()
    }

    deinit {
        locationManager.stopUpdatingLocation()
        locationManager.delegate = nil
        observers.removeAll()
    }

    override func didBindUIWithViewModel() {
        super.didBindUIWithViewModel()
        guard let selectedSegment = selectedSegment else { return }
        selectSegment?(selectedSegment)
    }

    func didSelect(segment: Int) {
        locationKind = LocationKind.allCases[segment]
    }
}

extension LocationViewModel: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let newLocation = locations.first else { return }
        lastLocation = newLocation.coordinate
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            locationManager.startUpdatingLocation()

        case .denied, .notDetermined, .restricted:
            break

        default:
            break
        }
    }
}

extension LocationViewModel: ProvidesLocation {
    func addObserver(_ observer: LocationObserver) {
        observers.append(observer)
    }

    func removeObserver(_ observer: LocationObserver) {
        guard let index = observers.firstIndex(where: { $0 === observer }) else { return }
        observers.remove(at: index)
    }
}


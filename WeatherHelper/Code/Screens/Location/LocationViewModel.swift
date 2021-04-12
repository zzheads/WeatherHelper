//
//  LocationViewModel.swift
//  WeatherHelper
//
//  Created by Алексей Папин on 11.04.2021.
//

import CoreLocation
import UIKit

final class LocationViewModel: BaseViewModel {
    enum LocationKind: String, CaseIterable {
        case location
        case city
        case coordinate

        var title: String { rawValue.capitalized }
    }
    
    struct Data {
        var location: CLLocationCoordinate2D?
        var city: String?
        var lat: CLLocationDegrees?
        var lon: CLLocationDegrees?
        var coordinate: CLLocationCoordinate2D? {
            guard let lat = lat, let lon = lon else { return nil }
            return CLLocationCoordinate2D(latitude: lat, longitude: lon)
        }
    }

    var selectSegment: ((Int) -> Void)?
    var didSetLocationKind: ((LocationKind, Data) -> Void)?

    var items: [String] = LocationKind.allCases.map { $0.title }

    private var observers: [LocationObserver] = []
    private var locationKind: LocationKind! {
        didSet { didSetLocationKind?(locationKind, data) }
    }
    var data = Data() {
        didSet { didSetLocationKind?(locationKind, data) }
    }
    private var selectedSegment: Int? { items.firstIndex(of: locationKind.title) }

    private lazy var locationManager: CLLocationManager = {
        let manager = CLLocationManager()
        manager.delegate = self
        return manager
    }()

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
        locationKind = .location
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
        data.location = newLocation.coordinate
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


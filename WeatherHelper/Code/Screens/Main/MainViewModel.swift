//
//  MainViewModel.swift
//  WeatherHelper
//
//  Created by Алексей Папин on 06.04.2021.
//

import UIKit
import Swinject

final class MainViewModel: BaseViewModel {
    private enum Key: String, StringRawValueable {
        case iconsAbsoluteString
    }

    enum ViewState {
        case loading
        case loaded(Result<CurrentWeatherResponse, Error>)
    }

    private let dependenciesProvider = DependenciesProvider()
    private lazy var plistProvider: ProvidesPlist = dependenciesProvider.resolve(ProvidesPlist.self)!
    private lazy var service: IWeatherService = dependenciesProvider.resolve(IWeatherService.self)!

    var updateViewState: ((ViewState) -> Void)?

    override func initialSetup() {
        super.initialSetup()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateViewState?(.loading)

        service.fetchCurrent([.latitude(38), .longitude(-78.25)]) {
            [weak self] result in
            self?.updateViewState?(.loaded(result))
        }
    }

    func iconURL(icon: String) -> URL? {
        guard let iconsAbsoluteString = plistProvider[Key.iconsAbsoluteString.rawValue] as? String else {
            return nil
        }
        return URL(string: [iconsAbsoluteString, icon, ".png"].joined())
    }
}

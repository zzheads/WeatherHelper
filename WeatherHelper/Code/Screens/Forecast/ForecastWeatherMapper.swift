//
//  ForecastWeatherMapper.swift
//  WeatherHelper
//
//  Created by Алексей Папин on 10.04.2021.
//

import UIKit

protocol MappingWeather: AnyObject {
    func temperature(_ temp: Double, units: WeatherRequest.Parameter.Units) -> String
    func iconURL(icon: String) -> URL?
    func cellModel(data: ForecastWeatherResponse.Data) -> ForecastWeatherCell.ViewModel
}

final class WeatherMapper: MappingWeather {
    private enum Key: String, StringRawValueable {
        case iconsAbsoluteString
        case pngExtension = ".png"
    }

    private struct Appearance {
        let dateAttributes: [NSAttributedString.Key: Any] = [.font: UIFont.systemFont(ofSize: 13, weight: .medium)]
        let tempAttributes: [NSAttributedString.Key: Any] = [.font: UIFont.systemFont(ofSize: 33, weight: .bold)]
    }

    private let plistProvider: ProvidesPlist
    private let appearance = Appearance()

    init(plistProvider: ProvidesPlist) {
        self.plistProvider = plistProvider
    }

    func temperature(_ temp: Double, units: WeatherRequest.Parameter.Units) -> String {
        [temp.description, units.degrees].joined()
    }

    func iconURL(icon: String) -> URL? {
        guard let iconsAbsoluteString = plistProvider[Key.iconsAbsoluteString.rawValue] as? String else {
            return nil
        }
        return URL(string: [iconsAbsoluteString, icon, Key.pngExtension.rawValue].joined())
    }

    func cellModel(data: ForecastWeatherResponse.Data) -> ForecastWeatherCell.ViewModel {
        let date = NSAttributedString(
            string: data.datetime,
            attributes: appearance.dateAttributes
        )
        
        let temp = NSAttributedString(
            string: temperature(data.temp, units: .metric),
            attributes: appearance.tempAttributes
        )

        return ForecastWeatherCell.ViewModel(
            date: date,
            icon: iconURL(icon: data.weather.icon),
            temperature: temp
        )
    }
}

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
    func cellModel(data: ForecastWeatherResponse.Data, style: WeatherMapper.AppearanceStyle) -> ForecastWeatherCell.ViewModel
}

final class WeatherMapper: MappingWeather {
    private enum Key: String, StringRawValueable {
        case iconsAbsoluteString
        case pngExtension = ".png"
    }

    enum AppearanceStyle {
        case light(date: NSTextAlignment = .center, temp: NSTextAlignment = .center)
        case medium(date: NSTextAlignment = .center, temp: NSTextAlignment = .center)
        case large(date: NSTextAlignment = .center, temp: NSTextAlignment = .center)

        var font: (
            date: UIFont,
            temp: UIFont
        ) {
            let dateSize: CGFloat
            let tempSize: CGFloat
            switch self {
            case .medium:
                dateSize = 13
                tempSize = 23
            case .light:
                dateSize = 9
                tempSize = 19
            case .large:
                dateSize = 17
                tempSize = 33
            }
            return (date: .systemFont(ofSize: dateSize, weight: .medium),
                    temp: .systemFont(ofSize: tempSize, weight: .bold))
        }

        var paragraphStyle: (
            date: NSParagraphStyle,
            temp: NSParagraphStyle
        ) {
            let dateParagraphStyle = NSMutableParagraphStyle()
            let tempParagraphStyle = NSMutableParagraphStyle()
            switch self {
            case let .medium(date, temp):
                dateParagraphStyle.alignment = date
                tempParagraphStyle.alignment = temp
            case let .large(date, temp):
                dateParagraphStyle.alignment = date
                tempParagraphStyle.alignment = temp
            case let .light(date, temp):
                dateParagraphStyle.alignment = date
                tempParagraphStyle.alignment = temp
            }
            return (
                date: dateParagraphStyle,
                temp: tempParagraphStyle
            )
        }

        var attributes: (date: [NSAttributedString.Key: Any], temp: [NSAttributedString.Key: Any]) {
            return (
                date: [.font: font.date, .paragraphStyle: paragraphStyle.date],
                temp: [.font: font.temp, .paragraphStyle: paragraphStyle.temp]
            )
        }
    }

    private let plistProvider: ProvidesPlist

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

    func cellModel(data: ForecastWeatherResponse.Data, style: AppearanceStyle) -> ForecastWeatherCell.ViewModel {
        let date = NSAttributedString(
            string: data.datetime,
            attributes: style.attributes.date
        )
        
        let temp = NSAttributedString(
            string: temperature(data.temp, units: .metric),
            attributes: style.attributes.temp
        )

        return ForecastWeatherCell.ViewModel(
            date: date,
            icon: iconURL(icon: data.weather.icon),
            temperature: temp
        )
    }

    func cellModel(data: ForecastWeatherResponse.Data) -> ForecastWeatherCell.ViewModel {
        cellModel(data: data, style: AppearanceStyle.medium())
    }
}

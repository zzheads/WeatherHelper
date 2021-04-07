//
//  TabBarItemViewModel.swift
//  WeatherHelper
//
//  Created by Алексей Папин on 06.04.2021.
//

import UIKit

enum TabBarItem: Int, CaseIterable {
    private enum Constant: String {
        case sun = "sun.max"
        case wind
        case main
        case forecast
    }

    case main
    case forecast

    var title: String? {
        switch self {
        case .main: return Constant.main.rawValue
        case .forecast: return Constant.forecast.rawValue
        }
    }

    var image: UIImage? {
        switch self {
        case .main: return UIImage(systemName: Constant.sun.rawValue)
        case .forecast: return UIImage(systemName: Constant.wind.rawValue)
        }
    }

    var tabBarItem: UITabBarItem {
        UITabBarItem(
            title: title,
            image: image,
            tag: rawValue
        )
    }

    var controller: UIViewController {
        let controller: UIViewController
        switch self {
        case .main: controller = MainViewController(viewModel: MainViewModel())
        case .forecast: controller = ForecastViewController(viewModel: ForecastViewModel())
        }
        controller.tabBarItem = tabBarItem
        return controller
    }
}

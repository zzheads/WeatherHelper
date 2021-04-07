//
//  TabBarItemViewModel.swift
//  WeatherHelper
//
//  Created by Алексей Папин on 06.04.2021.
//

import UIKit

enum TabBarItem: Int, CaseIterable {
    case main
    case forecast

    var title: String {
        switch self {
        case .main: return "Main"
        case .forecast: return "Forecast"
        }
    }

    var image: UIImage {
        switch self {
        case .main: return UIImage(systemName: "sun.max")!
        case .forecast: return UIImage(systemName: "wind")!
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

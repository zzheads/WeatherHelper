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
        case location
    }

    case main
    case forecast
    case location

    var title: String? {
        switch self {
        case .main: return Constant.main.rawValue
        case .forecast: return Constant.forecast.rawValue
        case .location: return Constant.location.rawValue
        }
    }

    var image: UIImage? {
        switch self {
        case .main: return UIImage(systemName: Constant.sun.rawValue)
        case .forecast: return UIImage(systemName: Constant.wind.rawValue)
        case .location: return UIImage(systemName: Constant.location.rawValue)
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
        case .location: controller = LocationViewController(viewModel: LocationViewModel())
        }
        controller.title = title
        let navController = navigationController(rootController: controller)
        navController.tabBarItem = tabBarItem
        return navController
    }

    private func navigationController(rootController: UIViewController) -> UINavigationController {
        let navController = UINavigationController(rootViewController: rootController)
        navController.navigationBar.barTintColor = .darkBlueberry
        navController.navigationBar.barStyle = .black
        return navController
    }
}

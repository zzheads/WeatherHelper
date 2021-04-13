//
//  AppDelegate.swift
//  WeatherHelper
//
//  Created by Алексей Папин on 06.04.2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let locationProvider = DependenciesProvider.shared.resolve(ProvidesLocation.self)
        
        let model = TabBarViewModel(selected: .forecast, locationProvider: locationProvider)
        let tabBarController = TabBarViewController(viewModel: model)
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
        return true
    }
}


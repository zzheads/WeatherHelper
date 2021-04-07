//
//  TabBarViewModel.swift
//  WeatherHelper
//
//  Created by Алексей Папин on 06.04.2021.
//

import UIKit

final class TabBarViewModel: NSObject {
    let items: [TabBarItem]
    var selected: TabBarItem?
    var selectItem: ((TabBarItem?) -> Void)?

    init(items: [TabBarItem] = TabBarItem.allCases, selected: TabBarItem? = nil) {
        self.items = items
        self.selected = selected
    }

    func viewDidLoad() {
    }

    func viewWillAppear() {
        selectItem?(selected)
    }
}

extension TabBarViewModel: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        guard
            let rawValue = viewController.tabBarItem?.tag,
            let item = TabBarItem(rawValue: rawValue),
            selected != item
        else {
            return
        }
        switch item {
        case .main: break
        case .forecast: break
        }
        selected = item
    }
}

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
    weak var locationProvider: ProvidesLocation?
    
    var setControllers: (([UIViewController], Bool) -> Void)?

    init(
        items: [TabBarItem] = TabBarItem.allCases,
        selected: TabBarItem? = nil,
        locationProvider: ProvidesLocation?
    ) {
        self.items = items
        self.selected = selected
        self.locationProvider = locationProvider
    }

    func viewDidLoad() {
    }

    func viewWillAppear() {
        let controllers: [UIViewController] = items.map { (item: TabBarItem) in
            var model: BaseViewModel?
            if case .location = item {
                model = locationProvider as? LocationViewModel
            }
            return item.controller(viewModel: model)
        }
        
        setControllers?(controllers, false)
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
        case .main:
            break
        case .forecast:
            break
        case .location:
            break
        }
        selected = item
    }
}

//
//  TabRouter.swift
//  ZConcept
//
//  Created by Alexey Papin on 27/10/2019.
//  Copyright © 2019 Alexey Papin. All rights reserved.
//

import UIKit

final class TabRouter: NSObject {

    private let rootTabBarController: UITabBarController
    private var completions = [UIViewController: () -> Void]()

    init(rootTabBarController: UITabBarController) {
        self.rootTabBarController = rootTabBarController
        super.init()
    }

    private func runCompletion(for controller: UIViewController) {
        guard let completion = completions[controller] else { return }
        completion()
        completions.removeValue(forKey: controller)
    }

}

// MARK: - TabRoutable

extension TabRouter: TabRoutable {

    var toPresent: UIViewController? {
        return self.rootTabBarController
    }

    func set(_ modules: [Presentable], animated: Bool) {
        let controllers = modules.compactMap({ $0.toPresent })
        rootTabBarController.setViewControllers(controllers,
                                                animated: animated)
    }

    func set(_ module: Presentable?, at index: Int) {
        guard let controller = module?.toPresent else { return }
        var controllers = rootTabBarController.viewControllers
        controllers?.remove(at: index)
        controllers?.insert(controller, at: index)
        rootTabBarController.setViewControllers(controllers,
                                                animated: false)
    }

    func insert(_ module: Presentable?, at index: Int) {
        guard let controller = module?.toPresent else { return }
        var controllers = rootTabBarController.viewControllers ?? [UIViewController]()
        controllers.insert(controller, at: index)
        rootTabBarController.setViewControllers(controllers,
                                                animated: false)
    }
    
    func remove(_ module: Presentable?) {
        guard let controller = module?.toPresent else { return }
        var controllers = rootTabBarController.viewControllers
        controllers?.removeAll(where: { $0 === controller })
        rootTabBarController.setViewControllers(controllers, animated: false)
    }
    
    func removeAll() {
        rootTabBarController.setViewControllers([], animated: false)
    }

    func show(_ module: Presentable?) {
        guard let controller = module?.toPresent else { return }
        guard let index = rootTabBarController.viewControllers?.firstIndex(of: controller) else {
            return
        }

        showModuleAt(index: index)
    }

    func showModuleAt(index: Int) {
        rootTabBarController.selectedIndex = index
    }
}

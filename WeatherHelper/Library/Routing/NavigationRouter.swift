//
//  NavigationRouter.swift
//  ZConcept
//
//  Created by Alexey Papin on 27/10/2019.
//  Copyright © 2019 Alexey Papin. All rights reserved.
//

import UIKit

final class NavigationRouter: NSObject {

    private let rootNavigationController: UINavigationController
    private var completions = [UIViewController: () -> Void]()

    init(rootNavigationController: UINavigationController) {
        self.rootNavigationController = rootNavigationController
        super.init()
        rootNavigationController.delegate = self
    }

    private func runCompletion(for controller: UIViewController) {
        guard let completion = completions[controller] else { return }
        completion()
        completions.removeValue(forKey: controller)
    }
}

// MARK: - NavigationRoutable

extension NavigationRouter: NavigationRoutable {

    var toPresent: UIViewController? {
        return self.rootNavigationController
    }

    func present(_ module: Presentable?, animated: Bool = true) {
        guard let controller = module?.toPresent else { return }
        rootNavigationController.present(controller, animated: animated, completion: nil)
    }

    func push(_ module: Presentable?, animated: Bool = true, completion: (() -> Void)? = nil) {
        guard
            let controller = module?.toPresent,
            !(controller is UINavigationController)
            else { assertionFailure("⚠️Deprecated push UINavigationController."); return }

        if let completion = completion {
            completions[controller] = completion
        }

        rootNavigationController.pushViewController(controller, animated: animated)
    }

    func popModule(animated: Bool = true) {
        if let controller = rootNavigationController.popViewController(animated: animated) {
            runCompletion(for: controller)
        }
    }

    func dismissModule(animated: Bool = true, completion: (() -> Void)? = nil) {
        rootNavigationController.dismiss(animated: animated, completion: completion)
    }

    func setRootModule(_ module: Presentable?, hideBar: Bool = false) {
        guard let controller = module?.toPresent else { return }
        rootNavigationController.setViewControllers([controller], animated: false)
        rootNavigationController.isNavigationBarHidden = hideBar
    }

    func popToRootModule(animated: Bool = true) {
        if let controllers = rootNavigationController.popToRootViewController(animated: animated) {
            controllers.forEach { controller in
                runCompletion(for: controller)
            }
        }
    }
}

extension NavigationRouter: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController,
                              didShow viewController: UIViewController,
                              animated: Bool) {
        guard
            let fromViewController = navigationController.transitionCoordinator?.viewController(forKey: .from),
            !navigationController.viewControllers.contains(fromViewController) else {
                return
        }

        runCompletion(for: fromViewController)
    }
}

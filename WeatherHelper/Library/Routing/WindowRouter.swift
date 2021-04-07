//
//  WindowRouter.swift
//  ZConcept
//
//  Created by Alexey Papin on 27/10/2019.
//  Copyright © 2019 Alexey Papin. All rights reserved.
//

import UIKit

final class WindowRouter: NSObject {

    private let window: UIWindow
    private var rootViewController: UIViewController?

    init(window: UIWindow) {
        self.window = window
    }
}

extension WindowRouter: WindowRoutable {

    var toPresent: UIViewController? {
        return rootViewController
    }

    func setRootModule(_ module: Presentable?) {
        guard let controller = module?.toPresent else { return }
        
        window.rootViewController = controller
        rootViewController?.view.removeFromSuperview()
        rootViewController = controller
    }
}

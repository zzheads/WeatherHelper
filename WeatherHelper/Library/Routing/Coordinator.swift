//
//  Coordinator.swift
//  ZConcept
//
//  Created by Alexey Papin on 27/10/2019.
//  Copyright © 2019 Alexey Papin. All rights reserved.
//

import Foundation

class Coordinator<RouterType: Routable>: Coordinatable {

    private var childCoordinators = [Coordinatable]()

    let router: RouterType
    
    // MARK: - Init

    init(router: RouterType) {
        self.router = router
    }
    
    // MARK: - Deinit
    
    deinit {
        print("\(String(describing: self)) coordinator deinit")
    }
    
    // MARK: - Coordinatable
    
    func start() {}

    func addChild(_ child: Coordinatable) {
        guard !childCoordinators.contains(where: { $0 === child }) else {
            return
        }

        childCoordinators.append(child)
    }

    func removeChild(_ child: Coordinatable?) {
        guard !childCoordinators.isEmpty, let child = child else {
            return
        }

        childCoordinators.removeAll(where: { $0 === child })
    }
    
    func removeAllChildren() {
        childCoordinators.removeAll()
    }
}

//
//  Routable.swift
//  ZConcept
//
//  Created by Alexey Papin on 27/10/2019.
//  Copyright © 2019 Alexey Papin. All rights reserved.
//

import Foundation

protocol Routable: Presentable {}

protocol NavigationRoutable: Routable {

    func present(_ module: Presentable?, animated: Bool)

    func push(_ module: Presentable?, animated: Bool, completion: (() -> Void)?)

    func popModule(animated: Bool)

    func dismissModule(animated: Bool, completion: (() -> Void)?)

    func setRootModule(_ module: Presentable?, hideBar: Bool)

    func popToRootModule(animated: Bool)
}

protocol WindowRoutable: Routable {

    func setRootModule(_ module: Presentable?)
}

protocol TabRoutable: Routable {

    func set(_ modules: [Presentable], animated: Bool)

    func set(_ module: Presentable?, at index: Int)

    func insert(_ module: Presentable?, at index: Int)

    func show(_ module: Presentable?)

    func showModuleAt(index: Int)
    
    func remove(_ module: Presentable?)
    
    func removeAll()
}

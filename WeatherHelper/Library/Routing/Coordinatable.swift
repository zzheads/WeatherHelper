//
//  Coordinatable.swift
//  ZConcept
//
//  Created by Alexey Papin on 27/10/2019.
//  Copyright © 2019 Alexey Papin. All rights reserved.
//

import Foundation

protocol Coordinatable: AnyObject {

    func start()

    func addChild(_ child: Coordinatable)

    func removeChild(_ child: Coordinatable?)
    
    func removeAllChildren()
}

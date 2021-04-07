//
//  UIView+Extension.swift
//  WeatherHelper
//
//  Created by Алексей Папин on 07.04.2021.
//

import UIKit

extension UIView {
    func addSubviews(_ subviews: [UIView]) {
        subviews.forEach { addSubview($0) }
    }
}

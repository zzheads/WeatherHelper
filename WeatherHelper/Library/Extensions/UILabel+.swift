//
//  UILabel+.swift
//  IdealInvestor
//
//  Created by Алексей Папин on 30.11.2020.
//

import UIKit

extension UILabel {
    struct Model {
        var font: UIFont
        var textColor: UIColor
        var backgroundColor: UIColor
        var textAlignment: NSTextAlignment
        var backgroundAlpha: CGFloat
        var alpha: CGFloat
        var cornerRadius: CGFloat
    }
    
    func configure(with model: Model) {
        font = model.font
        textColor = model.textColor
        backgroundColor = model.backgroundColor.withAlphaComponent(model.backgroundAlpha)
        textAlignment = model.textAlignment
        alpha = model.alpha
        layer.cornerRadius = model.cornerRadius
    }
}

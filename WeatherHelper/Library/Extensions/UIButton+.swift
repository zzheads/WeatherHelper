//
//  UIButton+.swift
//  IdealInvestor
//
//  Created by Алексей Папин on 25.11.2020.
//

import UIKit

extension UIButton {
    public enum ModelType {
        case green(NSAttributedString?)
        case blue(NSAttributedString?)
        case red(NSAttributedString?)
    }
    
    static func model(forType modelType: ModelType) -> Model {
        switch modelType {
        case let .green(title): return .init(title: title, cornerRadius: 6, backgroundColor: UIColor.Green.persianGreen)
        case let .blue(title): return .init(title: title, cornerRadius: 6, backgroundColor: UIColor.Blue.blueWhale)
        case let .red(title): return .init(title: title, cornerRadius: 6, backgroundColor: UIColor.Red.valencia)
        }
    }
    
    struct Model {
        let title: NSAttributedString?
        let cornerRadius: CGFloat?
        var backgroundColor: UIColor = .clear
        var isEnabled: Bool = true
    }
    
    func configure(with model: Model) {
        setAttributedTitle(model.title, for: .normal)
        backgroundColor = model.isEnabled ? model.backgroundColor : UIColor.Gray.iron
        layer.cornerRadius = model.cornerRadius ?? 0
        isEnabled = model.isEnabled
    }
}

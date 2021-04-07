//
//  TextField.swift
//  IdealInvestor
//
//  Created by Алексей Папин on 29.11.2020.
//

import UIKit

class TextField: UITextField {
    static func configure(textField: UITextField, with model: Model) {
        textField.text = model.initialValue
        textField.placeholder = model.placeholder
        textField.backgroundColor = model.backgroundColor
        textField.font = model.font
        textField.textColor = model.textColor
        textField.autocorrectionType = .no
        textField.isSecureTextEntry = model.isSecureTextEntry
    }
    
    private struct Constants {
        static let font: UIFont = .mts(size: 15, weight: .medium)
        static let textColor: UIColor = UIColor.Blue.blueWhale
    }
    
    private var editingHandler: ((String?) -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup() {
        addTarget(self, action: #selector(edited(_:)), for: .editingChanged)
    }
    
    @objc private func edited(_ sender: TextField) {
        editingHandler?(sender.text)
    }
}

extension TextField {
    struct Model {
        var initialValue: String? = nil
        var placeholder: String?
        var backgroundColor: UIColor = UIColor.Gray.whiteSmoke
        var font: UIFont = Constants.font
        var textColor: UIColor = Constants.textColor
        var isSecureTextEntry: Bool = false
        var handler: ((String?) -> Void)?
    }
    
    func configure(with model: Model) {
        TextField.configure(textField: self, with: model)
        editingHandler = model.handler
    }
}

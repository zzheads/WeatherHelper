//
//  UITextView+.swift
//  IdealInvestor
//
//  Created by Алексей Папин on 29.11.2020.
//

import UIKit

extension UITextView {
    struct Model {
        var attributedText: NSAttributedString?
        var backgroundColor: UIColor = .clear
        var textAlignment: NSTextAlignment = .justified
        var delegate: UITextViewDelegate?
        var contentInset: UIEdgeInsets = .zero
    }
    
    func configure(with model: Model) {
        attributedText = model.attributedText
        backgroundColor = model.backgroundColor
        textAlignment = model.textAlignment
        delegate = model.delegate
        contentInset = model.contentInset
    }
}

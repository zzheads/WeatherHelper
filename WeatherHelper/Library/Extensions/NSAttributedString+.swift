//
//  NSAttributedString+.swift
//  IdealInvestor
//
//  Created by Алексей Папин on 29.11.2020.
//

import Foundation

extension NSAttributedString {
    struct LinkedStringModel {
        var string: String
        var url: URL?
    }
    
    static func attributedString(of models: [LinkedStringModel],
                                 normalAttributes: [NSAttributedString.Key: Any],
                                 linkedAttributes: [NSAttributedString.Key: Any]) -> NSAttributedString {
        let result = NSMutableAttributedString(string: "", attributes: nil)
        for model in models {
            if let url = model.url {
                let linked = NSAttributedString(string: model.string, attributes: normalAttributes)
                let range = NSMakeRange(result.length, linked.length)
                result.append(linked)
                var linkedAttributes = linkedAttributes
                linkedAttributes.updateValue(url, forKey: .link)
                result.setAttributes(linkedAttributes, range: range)
            } else {
                let normal = NSAttributedString(string: model.string, attributes: normalAttributes)
                result.append(normal)
            }
        }
        return result
    }        
}

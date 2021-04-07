//
//  Font.swift
//  IdealInvestor
//
//  Created by Алексей Папин on 11.11.2020.
//

import UIKit

extension UIFont.Weight: CustomStringConvertible {
    public var description: String {
        switch self {
        case .black: return "Black"
        case .bold: return "Bold"
        case .heavy: return "Heavy"
        case .light: return "Light"
        case .medium: return "Medium"
        case .regular: return "Regular"
        case .semibold: return "Semibold"
        case .thin: return "Thin"
        case .ultraLight: return "Ultralight"
        default: return "Regular"
        }
    }
}

extension UIFont {
    static let mtsFontName = "MTSSans"
    
    static func mts(size: CGFloat, weight: UIFont.Weight) -> UIFont {
        let name = [mtsFontName, weight.description].joined(separator: "-")
        return UIFont(name: name, size: size)!
    }
}

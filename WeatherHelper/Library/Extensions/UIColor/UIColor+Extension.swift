//
//  UIColorExtension.swift
//  Rumedsi
//
//  Created by Andrey Tetyushin on 18/08/16.
//  Copyright © 2016 Stream LLC. All rights reserved.
//

import UIKit

public extension UIColor {

    // MARK: - Construction

    @available(*, deprecated, message: "Use init(rgbaHex:) instead")
    convenience init(rgba: UInt) {
        self.init(red: CGFloat((rgba >> 24) & 0xff) / 255.0,
                  green: CGFloat((rgba >> 16) & 0xff) / 255.0,
                  blue: CGFloat((rgba >> 8) & 0xff) / 255.0,
                  alpha: CGFloat((rgba >> 0) & 0xff) / 255.0)
    }

    convenience init(rgbaHex: UInt) {
        self.init(red: CGFloat((rgbaHex >> 24) & 0xff) / 255.0,
                  green: CGFloat((rgbaHex >> 16) & 0xff) / 255.0,
                  blue: CGFloat((rgbaHex >> 8) & 0xff) / 255.0,
                  alpha: CGFloat((rgbaHex >> 0) & 0xff) / 255.0)
    }

    // MARK: - Functions

    func toHexString() -> String {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0

        getRed(&red, green: &green, blue: &blue, alpha: &alpha)

        let rgb: Int = (Int)(red * 255) << 16 | (Int)(green * 255) << 8 | (Int)(blue * 255) << 0

        return NSString(format: "#%06x", rgb) as String
    }

}

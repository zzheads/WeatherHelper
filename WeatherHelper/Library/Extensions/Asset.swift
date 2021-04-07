//
//  Asset.swift
//  IdealInvestor
//
//  Created by Алексей Папин on 27.11.2020.
//

import UIKit

protocol StringRawValueable {
    var rawValue: String { get }
}

class Asset {
    enum Logo: String, StringRawValueable {
        case h_blackOnWhite = "horizontal_black_on_white_by_logaster"
        case h_onCorporate = "horizontal_on_corporate_by_logaster"
        case h_onNegative = "horizontal_on_negative_by_logaster"
        case h_onTransparent = "horizontal_on_transparent_by_logaster"
        case h_onWhite = "horizontal_on_white_by_logaster"
        case v_blackOnWhite = "vertical_black_on_white_by_logaster"
        case v_onCorporate = "vertical_on_corporate_by_logaster"
        case v_onNegative = "vertical_on_negative_by_logaster"
        case v_onTransparent = "vertical_on_transparent_by_logaster"
        case v_onWhite = "vertical_on_white_by_logaster"
    }
    
    static func image(_ value: StringRawValueable) -> UIImage {
        UIImage(imageLiteralResourceName: value.rawValue)
    }
}

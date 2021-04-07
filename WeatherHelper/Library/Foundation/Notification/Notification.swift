//
//  Notification.swift
//  ZConcept
//
//  Created by Alexey Papin on 28/10/2019.
//  Copyright © 2019 Stream. All rights reserved.
//

import UIKit

extension Notification {
    var keyboardSize: CGSize? {
        return (userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.size
    }

    var keyboardAnimationDuration: Double? {
        return userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double
    }

    var keyboardAnimationCurve: UIView.AnimationCurve? {
        guard let curveUInt = (userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as? NSNumber)?.intValue else {
            return nil
        }

        return UIView.AnimationCurve(rawValue: curveUInt)
    }
}

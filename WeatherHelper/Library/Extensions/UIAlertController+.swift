//
//  UIAlertController.swift
//  IdealInvestor
//
//  Created by Алексей Папин on 30.11.2020.
//

import UIKit

extension UIAlertController {
    class func getTextController(title: String?, placeholder: String?, completion: ((String?) -> Void)?) -> UIAlertController {
        let controller = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) {
            [weak controller] _ in
            completion?(controller?.textFields?.first?.text)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        controller.addTextField() {
            textField in
            TextField.configure(textField: textField, with: .init(placeholder: placeholder, backgroundColor: .clear))
        }
        controller.addAction(okAction)
        controller.addAction(cancelAction)
        guard let title = title else { return controller }
        let attributedTitle = NSAttributedString(string: title, attributes: [.font: UIFont.mts(size: 15, weight: .bold), .foregroundColor: UIColor.Blue.blueWhale])
        controller.setValue(attributedTitle, forKey: "attributedTitle")
        return controller
    }
}

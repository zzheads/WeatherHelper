//
//  AlertController.swift
//  IdealInvestor
//
//  Created by Алексей Папин on 29.11.2020.
//

import UIKit

enum StaticAlertControllerError: Error {
    case notCorrectCode
}

class StaticAlertController: UIAlertController {
    
    var handler: ((Result<String?, StaticAlertControllerError>) -> Void)?
    var code: String?
    
    lazy var okAction: UIAlertAction = {
        let okAction = UIAlertAction(title: "OK", style: .default) {
            [weak self] _ in
            self?.handler?(.success(self?.textFields?.first?.text))
        }
        return okAction
    }()
    
    lazy var cancelAction: UIAlertAction = {
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) {
            [weak self] _ in
            self?.handler?(.failure(.notCorrectCode))
        }
        return cancelAction
    }()
            
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    func setup(code: String?, placeholder: String?, handler: ((Result<String?, StaticAlertControllerError>) -> Void)?) {
        self.code = code
        self.handler = handler
        addAction(okAction)
        addAction(cancelAction)
        addTextField() {
            [weak self] textField in
            TextField.configure(textField: textField, with: .init(placeholder: placeholder, backgroundColor: .clear))
            textField.addTarget(self, action: #selector(self?.edited(_:)), for: .allEditingEvents)
        }
        okAction.isEnabled = false
        guard let title = title else { return }
        let attributedTitle = NSAttributedString(string: title, attributes: [.font: UIFont.mts(size: 15, weight: .bold), .foregroundColor: UIColor.Blue.blueWhale])
        setValue(attributedTitle, forKey: "attributedTitle")
    }
    
    @objc private func edited(_ sender: UITextField) {
        okAction.isEnabled = sender.text == code
    }
}

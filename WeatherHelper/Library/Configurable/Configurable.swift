//
//  Configurable.swift
//  IdealInvestor
//
//  Created by Алексей Папин on 25.11.2020.
//

import UIKit

protocol ConfigurableCell: UITableViewCell {
    associatedtype Model
    
    static var reuseIdentifier: String { get }
    static var nib: UINib { get }
    func configure(with model: Model, onUpdate: ((Model) -> Void)?)
}

extension ConfigurableCell {
    static var reuseIdentifier: String { .init(describing: Self.self) }
    static var nib: UINib { .init(nibName: reuseIdentifier, bundle: nil) }
}

protocol ConfigurableRow {
    var reuseIdentifier: String { get }
    var nib: UINib { get }
    func configure(cell: UITableViewCell)
}

class Row<Cell: ConfigurableCell, Model>: NSObject, ConfigurableRow where Cell.Model == Model {
    var item: Model
    var onUpdate: ((Model) -> Void)?
    var reuseIdentifier: String { Cell.reuseIdentifier }
    var nib: UINib { Cell.nib }
    
    init(_ item: Model, onUpdate: ((Model) -> Void)? = nil) {
        self.item = item
        self.onUpdate = onUpdate
        super.init()
    }
    
    func configure(cell: UITableViewCell) {
        guard let cell = cell as? Cell else {
            return
        }
        cell.configure(with: item, onUpdate: onUpdate)
    }
}

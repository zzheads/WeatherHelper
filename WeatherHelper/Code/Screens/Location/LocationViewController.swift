//
//  LocationViewController.swift
//  WeatherHelper
//
//  Created by Алексей Папин on 11.04.2021.
//

import UIKit

final class LocationViewController: BaseViewController<LocationViewModel> {
    private struct Appearance {
        var insets: UIEdgeInsets {
            UIEdgeInsets(
                top: margin.y,
                left: margin.x,
                bottom: margin.y,
                right: margin.x
            )
        }
        let margin = CGPoint(x: 16, y: 8)
    }

    private let appearance = Appearance()

    private lazy var segmenetedControl: UISegmentedControl = {
        let control = UISegmentedControl(items: viewModel.items)
        control.addTarget(self, action: #selector(segmentDidChanged(_:)), for: .valueChanged)
        return control
    }()

    private lazy var latTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "Latitude"
        return textField
    }()

    private lazy var lonTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "Longitude"
        return textField
    }()

    private lazy var coordinateStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.addArrangedSubview(latTextField)
        stack.addArrangedSubview(lonTextField)
        return stack
    }()

    override func setupUI() {
        super.setupUI()
        view.backgroundColor = .whiteSmoke
        addSubviews()
        makeConstraints()
    }

    override func bindUIWithViewModel() {
        super.bindUIWithViewModel()
        viewModel.selectSegment = {
            [weak self] selected in
            self?.segmenetedControl.selectedSegmentIndex = selected
        }
    }

    private func addSubviews() {
        view.addSubviews([segmenetedControl, coordinateStackView])
    }

    private func makeConstraints() {
        segmenetedControl.snp.makeConstraints {
            $0.top.left.right.equalTo(view.safeAreaLayoutGuide).inset(appearance.insets)
        }

        coordinateStackView.snp.makeConstraints {
            $0.top.equalTo(segmenetedControl.snp.bottom).offset(appearance.margin.y)
            $0.left.right.equalToSuperview().inset(appearance.insets)
        }
    }

    @objc private func segmentDidChanged(_ sender: UISegmentedControl) {
        viewModel.didSelect(segment: sender.selectedSegmentIndex)
    }
}

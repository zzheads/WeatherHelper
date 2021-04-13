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
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.addArrangedSubview(latTextField)
        stack.addArrangedSubview(lonTextField)
        return stack
    }()
    
    private lazy var cityTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "City"
        return textField
    }()
    
    private lazy var resultLabel: LocationLabel = {
        let label = LocationLabel()
        label.font = .systemFont(ofSize: 11, weight: .regular)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()

    deinit {
        viewModel.removeObserver(resultLabel)
    }
    
    override func setupUI() {
        super.setupUI()
        view.backgroundColor = .whiteSmoke
        addSubviews()
        makeConstraints()
        [latTextField, lonTextField, cityTextField].forEach { $0.addTarget(self, action: #selector(didEdit(_:)), for: .allEditingEvents) }
        viewModel.addObserver(resultLabel)
    }

    override func bindUIWithViewModel() {
        super.bindUIWithViewModel()
        viewModel.selectSegment = {
            [weak self] selected in
            self?.segmenetedControl.selectedSegmentIndex = selected
        }
        viewModel.didSetLocationKind = {
            [weak self] kind, data in
            self?.coordinateStackView.isHidden = kind != .coordinate
            self?.cityTextField.isHidden = kind != .city
        }
    }

    private func addSubviews() {
        view.addSubviews([segmenetedControl, coordinateStackView, cityTextField, resultLabel])
    }

    private func makeConstraints() {
        segmenetedControl.snp.makeConstraints {
            $0.top.left.right.equalTo(view.safeAreaLayoutGuide).inset(appearance.insets)
        }

        coordinateStackView.snp.makeConstraints {
            $0.top.equalTo(segmenetedControl.snp.bottom).offset(appearance.margin.y)
            $0.left.right.equalToSuperview().inset(appearance.insets)
        }
        
        cityTextField.snp.makeConstraints {
            $0.top.equalTo(segmenetedControl.snp.bottom).offset(appearance.margin.y)
            $0.left.right.equalToSuperview().inset(appearance.insets)
        }
        
        resultLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.left.right.equalToSuperview().inset(appearance.insets)
        }
    }

    @objc private func segmentDidChanged(_ sender: UISegmentedControl) {
        viewModel.didSelect(segment: sender.selectedSegmentIndex)
    }
    
    @objc private func didEdit(_ sender: UITextField) {
        switch sender {
        case latTextField:
            guard let text = sender.text else {
                viewModel.data.lat = nil
                return
            }
            viewModel.data.lat = Double(text)
            
        case lonTextField:
            guard let text = sender.text else {
                viewModel.data.lon = nil
                return
            }
            viewModel.data.lon = Double(text)
            
        case cityTextField:
            viewModel.data.city = sender.text
            
        default:
            break
        }
    }
}

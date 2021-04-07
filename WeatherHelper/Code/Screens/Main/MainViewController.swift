//
//  MainViewController.swift
//  WeatherHelper
//
//  Created by Алексей Папин on 06.04.2021.
//

import UIKit
import SnapKit
import Nuke

final class MainViewController: BaseViewController<MainViewModel> {
    private struct Appearance {
        let margin: CGPoint = .init(x: 24, y: 16)
    }

    private let appearance = Appearance()

    private lazy var spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.color = .darkBlueberry
        spinner.hidesWhenStopped = true
        spinner.stopAnimating()
        return spinner
    }()

    private lazy var infoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.spacing = appearance.margin.y
        stackView.addArrangedSubview(locationLabel)
        stackView.addArrangedSubview(weatherStackView)
        stackView.addArrangedSubview(suggestionLabel)
        return stackView
    }()

    private lazy var locationLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13, weight: .medium)
        label.textAlignment = .center
        return label
    }()

    private lazy var weatherStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.spacing = appearance.margin.x / 2
        stackView.addArrangedSubview(weatherImageView)
        stackView.addArrangedSubview(temperatureLabel)
        return stackView
    }()

    private lazy var weatherImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    private lazy var temperatureLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 33, weight: .bold)
        label.textAlignment = .center
        return label
    }()

    private lazy var suggestionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13, weight: .medium)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()

    override func setupUI() {
        super.setupUI()
        view.backgroundColor = .whiteSmoke
        addSubviews()
        makeConstraints()
    }

    override func bindUIWithViewModel() {
        super.bindUIWithViewModel()

        viewModel.updateViewState = {
            [weak self] state in

            guard let self = self else { return }

            switch state {
            case .loading:
                self.infoStackView.isHidden = true
                self.spinner.startAnimating()

            case let .loaded(result):
                self.infoStackView.isHidden = false
                self.spinner.stopAnimating()

                switch result {
                case let .success(response):
                    self.locationLabel.text = response.location.description
                    self.temperatureLabel.text = response.temperatureWithSign
                    self.suggestionLabel.text = response.current.weather_descriptions.joined(separator: ",")
                    guard let path = response.current.weather_icons.first, let url = URL(string: path) else { return }
                    Nuke.loadImage(with: url, into: self.weatherImageView)

                case let .failure(error):
                    print(error)
                }
            }
        }
    }

    private func addSubviews() {
        view.addSubviews([infoStackView, spinner])
    }

    private func makeConstraints() {
        infoStackView.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(appearance.margin.x)
            $0.centerY.equalToSuperview()
        }

        spinner.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
}

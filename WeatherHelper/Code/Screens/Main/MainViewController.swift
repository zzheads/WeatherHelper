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

    private lazy var locationLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13, weight: .medium)
        label.textAlignment = .center
        return label
    }()

    private lazy var weatherStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.spacing = 16
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

        viewModel.updateWeather = {
            [weak self] response in

            guard let self = self else { return }
            self.locationLabel.text = response.location.description
            self.temperatureLabel.text = response.temperatureWithSign
            self.suggestionLabel.text = response.current.weather_descriptions.joined(separator: ",")
            guard let path = response.current.weather_icons.first, let url = URL(string: path) else { return }
            Nuke.loadImage(with: url, into: self.weatherImageView)
        }
    }

    private func addSubviews() {
        weatherStackView.addArrangedSubview(weatherImageView)
        weatherStackView.addArrangedSubview(temperatureLabel)
        view.addSubviews([locationLabel, weatherStackView, suggestionLabel])
    }

    private func makeConstraints() {
        locationLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(appearance.margin.y)
            $0.left.right.equalToSuperview().inset(appearance.margin.x)
        }

        weatherStackView.snp.makeConstraints {
            $0.top.equalTo(locationLabel.snp.bottom).offset(appearance.margin.y)
            $0.centerX.equalToSuperview()
        }

        suggestionLabel.snp.makeConstraints {
            $0.top.equalTo(temperatureLabel.snp.bottom).offset(appearance.margin.y)
            $0.left.right.equalToSuperview().inset(appearance.margin.x)
        }
    }
}

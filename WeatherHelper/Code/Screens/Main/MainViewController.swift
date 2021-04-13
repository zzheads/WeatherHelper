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
        let smallFont: UIFont = .systemFont(ofSize: 11, weight: .regular)
        let normalFont: UIFont = .systemFont(ofSize: 13, weight: .medium)
        let bigFont: UIFont = .systemFont(ofSize: 33, weight: .bold)
    }

    private let appearance = Appearance()

    private lazy var spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.color = .greyHeather
        spinner.hidesWhenStopped = true
        spinner.stopAnimating()
        return spinner
    }()

    private lazy var locationMethodLabel: LocationLabel = {
        let label = LocationLabel()
        label.font = appearance.smallFont
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var infoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalCentering
        stackView.spacing = appearance.margin.y
        stackView.addArrangedSubview(locationLabel)
        stackView.addArrangedSubview(weatherStackView)
        stackView.addArrangedSubview(suggestionLabel)
        return stackView
    }()

    private lazy var locationLabel: UILabel = {
        let label = UILabel()
        label.font = appearance.normalFont
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()

    private lazy var weatherStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .equalCentering
        stackView.spacing = 0
        stackView.addArrangedSubview(UIView())
        stackView.addArrangedSubview(weatherImageView)
        stackView.addArrangedSubview(temperatureLabel)
        stackView.addArrangedSubview(UIView())
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
                self.locationMethodLabel.isHidden = true
                self.infoStackView.isHidden = true
                self.spinner.startAnimating()

            case let .loaded(result):
                self.locationMethodLabel.isHidden = false
                self.infoStackView.isHidden = false
                self.spinner.stopAnimating()

                switch result {
                case let .success(response):
                    self.locationLabel.text = response.data.first?.location
                    self.temperatureLabel.text = self.viewModel.temperature(temp: response.data.first?.temp)
                    self.suggestionLabel.text = response.data.first?.weather.description
                    guard let path = response.data.first?.weather.icon, let url = self.viewModel.iconURL(icon: path) else { return }
                    Nuke.loadImage(with: url, into: self.weatherImageView)

                case let .failure(error):
                    print(error)
                }
            }
        }
        
        viewModel.subscribeViews = {
            [weak self] provider in
            guard let self = self, let provider = provider else { return }
            provider.addObserver(self.locationMethodLabel)
        }
        
        viewModel.unsubscribeViews = {
            [weak self] provider in
            guard let self = self, let provider = provider else { return }
            provider.removeObserver(self.locationMethodLabel)
        }
    }

    private func addSubviews() {
        view.addSubviews([infoStackView, spinner, locationMethodLabel])
    }

    private func makeConstraints() {
        locationMethodLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(appearance.margin.y)
            $0.leading.trailing.equalToSuperview().inset(appearance.margin.x)
        }
        
        infoStackView.snp.makeConstraints {
            $0.center.equalToSuperview()
        }

        spinner.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
}

//
//  ForecastWeatherCell.swift
//  WeatherHelper
//
//  Created by Алексей Папин on 09.04.2021.
//

import UIKit
import SnapKit
import Nuke

final class ForecastWeatherCell: UITableViewCell {
    private struct Appearance {
        let margin = CGPoint(x: 16, y: 8)
    }

    private let appearance = Appearance()
    private lazy var spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .medium)
        spinner.color = .darkBlueberry
        spinner.hidesWhenStopped = true
        spinner.stopAnimating()
        return spinner
    }()

    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13, weight: .medium)
        label.textAlignment = .center
        return label
    }()

    private lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private lazy var temperatureLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 33, weight: .medium)
        label.textAlignment = .center
        return label
    }()

    override func prepareForReuse() {
        super.prepareForReuse()
        dateLabel.text = nil
        iconImageView.image = nil
        temperatureLabel.text = nil
    }

    private func addSubviews() {
        contentView.addSubviews([spinner, dateLabel, iconImageView, temperatureLabel])
    }

    private func makeConstraints() {
        spinner.snp.makeConstraints { $0.center.equalToSuperview() }

        dateLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(appearance.margin.x)
            $0.centerY.equalToSuperview()
        }

        iconImageView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.leading.equalTo(dateLabel.snp.trailing).offset(appearance.margin.x)
        }

        temperatureLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(iconImageView.snp.trailing).offset(appearance.margin.x)
            $0.trailing.equalToSuperview().inset(appearance.margin.x)
        }
    }
}

extension ForecastWeatherCell: ConfigurableCell {
    enum State {
        struct ViewModel {
            let date: NSAttributedString
            let icon: URL?
            let temperature: NSAttributedString
        }

        case loading
        case loaded(ViewModel)
    }

    func configure(with model: State, onUpdate: ((State) -> Void)?) {
        <#code#>
    }


}

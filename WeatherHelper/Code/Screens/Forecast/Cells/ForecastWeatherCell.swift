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
        let iconSize = CGSize(width: 44, height: 33)
        let margin = CGPoint(x: 8, y: 4)
    }

    private let appearance = Appearance()

    // MARK: - Subviews
    private lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    private let dateLabel = UILabel()
    private let temperatureLabel = UILabel()
    private var infoViews: [UIView] { [dateLabel, iconImageView, temperatureLabel] }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        dateLabel.text = nil
        iconImageView.image = nil
        temperatureLabel.text = nil
        Nuke.cancelRequest(for: iconImageView)
    }

    private func setupUI() {
        addSubviews()
        makeConstraints()
        backgroundColor = .clear
    }

    private func addSubviews() {
        contentView.addSubviews(infoViews)
    }

    private func makeConstraints() {
        iconImageView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(appearance.margin.y)
            $0.center.equalToSuperview()
            $0.size.equalTo(appearance.iconSize)
        }

        dateLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(appearance.margin.x)
            $0.trailing.equalTo(iconImageView.snp.leading).offset(-appearance.margin.x)
            $0.centerY.equalToSuperview()
        }

        temperatureLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(appearance.margin.x)
            $0.leading.equalTo(iconImageView.snp.trailing).offset(appearance.margin.x)
        }
    }
}

extension ForecastWeatherCell: ConfigurableCell {
    struct ViewModel {
        let date: NSAttributedString
        let icon: URL?
        let temperature: NSAttributedString
    }

    func configure(with model: ViewModel, onUpdate: ((ViewModel) -> Void)?) {
        dateLabel.attributedText = model.date
        temperatureLabel.attributedText = model.temperature
        guard let url = model.icon else {
            iconImageView.image = nil
            return
        }
        Nuke.loadImage(with: url, into: iconImageView)
    }
}

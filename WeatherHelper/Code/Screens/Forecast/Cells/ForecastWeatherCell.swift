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

    private lazy var infoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 0
        stackView.addArrangedSubview(dateLabel)
        stackView.addArrangedSubview(iconImageView)
        stackView.addArrangedSubview(temperatureLabel)
        return stackView
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

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubviews()
        makeConstraints()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        addSubviews()
        makeConstraints()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        dateLabel.text = nil
        iconImageView.image = nil
        temperatureLabel.text = nil
        Nuke.cancelRequest(for: iconImageView)
    }

    private func addSubviews() {
        contentView.addSubview(infoStackView)
    }

    private func makeConstraints() {
        infoStackView.snp.makeConstraints { $0.edges.equalToSuperview() }
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

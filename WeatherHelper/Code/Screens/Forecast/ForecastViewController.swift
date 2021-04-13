//
//  ForecastViewController.swift
//  WeatherHelper
//
//  Created by Алексей Папин on 07.04.2021.
//

import UIKit

final class ForecastViewController: BaseViewController<ForecastViewModel> {
    private struct Appearance {
        let smallFont: UIFont = .systemFont(ofSize: 11, weight: .regular)
        let margin = CGPoint(x: 16, y: 8)
    }

    private let appearance = Appearance()

    private lazy var spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.color = .greyRaven
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
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ForecastWeatherCell.self, forCellReuseIdentifier: ForecastWeatherCell.reuseIdentifier)
        return tableView
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
            self?.tableView.isHidden = state == .loading
            self?.spinner.isHidden = state == .loaded
            switch state {
            case .loading:
                self?.spinner.startAnimating()

            case .loaded:
                self?.spinner.stopAnimating()
                self?.tableView.reloadData()
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
        view.addSubviews([tableView, spinner, locationMethodLabel])
    }

    private func makeConstraints() {
        spinner.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        locationMethodLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(appearance.margin.y)
            $0.leading.trailing.equalToSuperview().inset(appearance.margin.x)
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(locationMethodLabel.snp.bottom)
            $0.left.right.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

extension ForecastViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.models.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ForecastWeatherCell.reuseIdentifier, for: indexPath) as! ForecastWeatherCell
        cell.configure(with: viewModel.models[indexPath.row]) {
            [weak self] newModel in
            self?.viewModel.models[indexPath.row] = newModel
        }
        return cell
    }

}

extension ForecastViewController: UITableViewDelegate {

}

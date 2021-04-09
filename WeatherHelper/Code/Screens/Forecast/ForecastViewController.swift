//
//  ForecastViewController.swift
//  WeatherHelper
//
//  Created by Алексей Папин on 07.04.2021.
//

import UIKit

final class ForecastViewController: BaseViewController<ForecastViewModel> {
    private struct Appearance {
        let margin = CGPoint(x: 16, y: 8)
    }

    private let appearance = Appearance()
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
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
        viewModel.reloadTableView = {
            [weak self] in
            self?.tableView.reloadData()
        }
    }

    private func addSubviews() {
        view.addSubview(tableView)
    }

    private func makeConstraints() {
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(appearance.margin.y)
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

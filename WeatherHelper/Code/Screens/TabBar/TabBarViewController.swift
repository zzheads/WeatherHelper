//
//  TabBarController.swift
//  WeatherHelper
//
//  Created by Алексей Папин on 06.04.2021.
//

import UIKit

final class TabBarViewController: UITabBarController {
    let viewModel: TabBarViewModel

    init(viewModel: TabBarViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.setViewControllers(viewModel.items.map { $0.controller }, animated: false)
        self.delegate = self.viewModel
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.selectItem = {
            [weak self] item in
            guard let self = self, let item = item, let index = self.viewModel.items.firstIndex(of: item) else { return }
            self.selectedIndex = index
        }

        viewModel.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.viewWillAppear()
    }
}

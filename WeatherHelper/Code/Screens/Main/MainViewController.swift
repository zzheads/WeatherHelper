//
//  MainViewController.swift
//  WeatherHelper
//
//  Created by Алексей Папин on 06.04.2021.
//

import UIKit

final class MainViewController: BaseViewController<MainViewModel> {
    

    override func initialSetup() {
        super.initialSetup()
        view.backgroundColor = .yellow
    }
}

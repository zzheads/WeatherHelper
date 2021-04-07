//
//  BaseViewController.swift
//  AlarTest
//
//  Created by Алексей Папин on 01.10.2020.
//

import UIKit

// MARK: - ViewModel
protocol ViewModel {
    var showController: ((UIViewController) -> Void)? { get set }
    var presentController: ((UIViewController, Bool, (() -> Void)?) -> Void)? { get set }
    var dismissController: (((() -> Void)?) -> UIViewController?)? { get set }
    
    func initialSetup()
    func viewDidLoad()
    func didBindUIWithViewModel()
    func viewWillAppear(_ animated: Bool)
    func viewDidAppear(_ animated: Bool)
    func viewWillDisappear(_ animated: Bool)
    func viewDidDisappear(_ animated: Bool)
}

// MARK: - ViewController
protocol ViewController: UIViewController {
    associatedtype ViewModelType: ViewModel
    var viewModel: ViewModelType { get }
}

// MARK: - BaseViewModel
class BaseViewModel: NSObject, ViewModel {
    var showController: ((UIViewController) -> Void)?
    var presentController: ((UIViewController, Bool, (() -> Void)?) -> Void)?
    var dismissController: (((() -> Void)?) -> UIViewController?)?
    
    func initialSetup() {}
    func viewDidLoad() {}
    func didBindUIWithViewModel() {}
    
    func viewWillAppear(_ animated: Bool) {}
    func viewDidAppear(_ animated: Bool) {}
    func viewWillDisappear(_ animated: Bool) {}
    func viewDidDisappear(_ animated: Bool) {}
}

// MARK: - BaseViewController
class BaseViewController<ViewModelType: ViewModel>: UIViewController, ViewController {
    var viewModel: ViewModelType

    init(viewModel: ViewModelType) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        initialSetup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initialSetup() {
        viewModel.initialSetup()
    }
    
    func setupUI() {}

    func bindUIWithViewModel() {
        viewModel.presentController = {
            [weak self] controller, animated, completion in
            self?.navigationController?.present(controller, animated: animated, completion: completion)
        }
        
        viewModel.showController = {
            [weak self] controller in
            if let navigationController = self?.navigationController {
                navigationController.pushViewController(controller, animated: true)
            } else {
                self?.show(controller, sender: self)
            }
        }
        
        viewModel.dismissController = {
            [weak self] completion in
            let rootController: UIViewController?
            if let navigationController = self?.navigationController {
                navigationController.popViewController(animated: true)
                rootController = navigationController.viewControllers.first
            } else {
                self?.dismiss(animated: true)
                rootController = self?.presentedViewController
            }
            completion?()
            return rootController
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDidLoad()
        setupUI()
        bindUIWithViewModel()
        viewModel.didBindUIWithViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.viewDidAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        viewModel.viewWillDisappear(animated)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        viewModel.viewDidDisappear(animated)
    }
}

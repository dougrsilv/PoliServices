//
//  HomeServicesViewController.swift
//  PoliServices
//
//  Created by Douglas  Rodrigues  on 28/02/23.
//

import UIKit
import UserNotifications

class HomeServicesViewController: UIViewController {
    
    // MARK: - Properties
    
    private let homeServiceView = HomeServicesView()
    private let viewModel: HomeServicesViewModel
    
    override func loadView() {
        view = homeServiceView
    }
    
    init(viewModel: HomeServicesViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        homeServiceView.delegate = self
        view.backgroundColor = UIColor(red: 0.925, green: 0.925, blue: 0.925, alpha: 1)
        viewModel.initTimer()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        homeServiceView.addGestureRecognizer(tapGesture)
        viewModel.delegate = self
        homeServiceView.subTitle.text = viewModel.dateAndHourNow()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        view.backgroundColor = UIColor(red: 0.925, green: 0.925, blue: 0.925, alpha: 1)
        viewModel.setupService()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
        view.backgroundColor = UIColor(red: 0.925, green: 0.925, blue: 0.925, alpha: 1)
    }
    
    // MARK: - Functions
    
    @objc func handleTap() {
        let serviceDetailViewModel = ServiceDetailViewModel()
        let serviceDetailViewController = ServiceDetailViewController(viewModel: serviceDetailViewModel)
        serviceDetailViewController.delegate = self
        navigationController?.pushViewController(serviceDetailViewController, animated: true)
    }
}

// MARK: - HomeServicesViewDelegate

extension HomeServicesViewController: HomeServicesViewDelegate {
    func buttonService() {
        let newServicesService = NewServicesService()
        let newServicesViewModel = NewServicesViewModel(service: newServicesService)
        let recipe = NewServicesViewController(viewModel: newServicesViewModel)
        let navBarOnModal: UINavigationController = UINavigationController(rootViewController: recipe)
        navBarOnModal.modalPresentationStyle = .fullScreen
        navigationController?.present(navBarOnModal, animated: true)
    }
}

// MARK: - HomeServicesViewModelDelegate

extension HomeServicesViewController: HomeServicesViewModelDelegate {
    func onStartDataHomeService(model: HomeModel) {
        homeServiceView.setParameter(model: model)
    }
    
    func hidesTimerCard(bool: Bool) {
        homeServiceView.setParameterHiden(values: bool)
    }
}

// MARK: - ServiceDetailViewControllerDelgate

extension HomeServicesViewController: ServiceDetailViewControllerDelgate {
    func cancelService(value: Bool) {
        homeServiceView.setParameterHiden(values: !value)
    }
}

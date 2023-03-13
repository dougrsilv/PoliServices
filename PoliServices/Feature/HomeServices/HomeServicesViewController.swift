//
//  HomeServicesViewController.swift
//  PoliServices
//
//  Created by Douglas  Rodrigues  on 28/02/23.
//

import UIKit

class HomeServicesViewController: UIViewController {
    
    // MARK: - Properties
    
    let homeServiceView = HomeServicesView()
    let viewModel: HomeServicesViewModel
    var count = 0
    
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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        view.backgroundColor = UIColor(red: 0.925, green: 0.925, blue: 0.925, alpha: 1)
        viewModel.delegate = self
        viewModel.setupService()
        homeServiceView.setParameter(model: viewModel)
        self.homeServiceView.layoutIfNeeded()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.delegate = self
        viewModel.setupService()
        homeServiceView.setParameter(model: viewModel)
        self.homeServiceView.layoutIfNeeded()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
        view.backgroundColor = UIColor(red: 0.925, green: 0.925, blue: 0.925, alpha: 1)
    }
    
    @objc func handleTap() {
        let serviceDetailViewModel = ServiceDetailViewModel()
        let serviceDetailViewController = ServiceDetailViewController(viewModel: serviceDetailViewModel)
        serviceDetailViewController.delegate = self
        navigationController?.pushViewController(serviceDetailViewController, animated: true)
    }
    
    func alertNumber(title: String, message: String) {
        let controller = UIAlertController(title: title, message: message, preferredStyle: .alert)
        controller.addAction(.init(title: "OK", style: .default, handler: { alert in
            let serviceDetailViewModel = ServiceDetailViewModel()
            let serviceDetailViewController = ServiceDetailViewController(viewModel: serviceDetailViewModel)
            serviceDetailViewController.delegate = self
            self.navigationController?.pushViewController(serviceDetailViewController, animated: true)
        }))
        present(controller, animated: true)
    }
}

// MARK: - HomeServicesViewDelegate

extension HomeServicesViewController: HomeServicesViewDelegate {
    func buttonService() {
        count = 0
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
    func timerEnable(bool: Bool) {
        UserDefaults.standard.set(bool, forKey: "service_Desabilita")
    }
    
    func timerAlert(bool: Bool) {
        if bool == true && count == 0 {
            alertNumber(title: "Agendamento", message: "Falta 15 minutos para o serviço")
            count = 1
        }
    }
    
    func timerBool(bool: Bool) {
        homeServiceView.setParameterHiden(values: bool)
    }
}

// MARK: - ServiceDetailViewControllerDelgate

extension HomeServicesViewController: ServiceDetailViewControllerDelgate {
    func cancelService(value: Bool) {
        homeServiceView.setParameterHiden(values: !value)
        UserDefaults.standard.removeObject(forKey: "service_date")
        UserDefaults.standard.removeObject(forKey: "service_name")
        UserDefaults.standard.removeObject(forKey: "service_color")
        UserDefaults.standard.removeObject(forKey: "service_hour_start")
        UserDefaults.standard.removeObject(forKey: "service_Desabilita")
        count = 0
    }
}

//
//  HomeServicesViewController.swift
//  PoliServices
//
//  Created by Douglas  Rodrigues  on 28/02/23.
//

import UIKit
import UserNotifications

protocol HomeServicesViewControllerLogic: AnyObject {
    func hidesTimerCardResults(bool: Bool)
    func onStartDataHomeServiceResults(model: HomeModel)
    func dateAndHourNowFormated(data: String)
}

class HomeServicesViewController: UIViewController {
    
    // MARK: - Properties
    
    private let homeServiceView = HomeServicesView()
    private let homeInteractor: HomeInteractorLogic
    
    override func loadView() {
        view = homeServiceView
    }
    
    init(homeInteractor: HomeInteractorLogic) {
        self.homeInteractor = homeInteractor
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
        homeInteractor.initTimer()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        homeServiceView.addGestureRecognizer(tapGesture)
        homeInteractor.captureDateAndHour()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        view.backgroundColor = UIColor(red: 0.925, green: 0.925, blue: 0.925, alpha: 1)
        homeInteractor.setupService()
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
        let configuration = NewServicesConfiguration()
        let newServicesConfiguration = configuration.build(service: newServicesService)
        
        let navBarOnModal: UINavigationController = UINavigationController(rootViewController: newServicesConfiguration)
        navBarOnModal.modalPresentationStyle = .fullScreen
        navigationController?.present(navBarOnModal, animated: true)
    }
}

// MARK: - HomeServicesViewControllerLogic

extension HomeServicesViewController: HomeServicesViewControllerLogic {
    func dateAndHourNowFormated(data: String)  {
        homeServiceView.subTitle.text = data
    }
    
    func hidesTimerCardResults(bool: Bool) {
        homeServiceView.setParameterHiden(values: bool)
    }
    
    func onStartDataHomeServiceResults(model: HomeModel) {
        homeServiceView.setParameter(model: model)
    }
}

// MARK: - ServiceDetailViewControllerDelgate

extension HomeServicesViewController: ServiceDetailViewControllerDelgate {
    func cancelService(value: Bool) {
        homeServiceView.setParameterHiden(values: !value)
    }
}

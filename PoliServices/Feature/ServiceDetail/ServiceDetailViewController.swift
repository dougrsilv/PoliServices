//
//  ServiceDetailViewController.swift
//  PoliServices
//
//  Created by Douglas  Rodrigues  on 09/03/23.
//

import UIKit

protocol ServiceDetailViewControllerDelgateLogic: AnyObject {
    func passServiceDetail(model: ServiceDetailModel)
}

protocol ServiceDetailViewControllerDelgate: AnyObject {
    func cancelService(value: Bool)
}

class ServiceDetailViewController: UIViewController {
    
    // MARK: - Properties
    
    private let serviceDetailView = ServiceDetailView()
    
    private let serviceInteractorLogic: ServiceDetailInteractorLogic
    
    weak var delegate: ServiceDetailViewControllerDelgate?
    
    init(serviceInteractorLogic: ServiceDetailInteractorLogic) {
        self.serviceInteractorLogic = serviceInteractorLogic
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Lifecyle
    
    override func loadView() {
        view = serviceDetailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        serviceDetailView.delegate = self
        title = "Detalhe Serviço"
        let backButton = UIBarButtonItem()
        backButton.title = ""
        navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        serviceInteractorLogic.saveDataServices()
    }
}

// MARK: - ServiceDetailViewDelegate

extension ServiceDetailViewController: ServiceDetailViewDelegate {
    func clickCancelButton() {
        let service = ReasonServiceService()
        let postAnalitcsService = PostAnalitcsService()
        let alertConfiguration = AlertServiceConfiguration()
        let alertConfigurationBuild = alertConfiguration.build(service: service,
                                                               postService: postAnalitcsService,
                                                               delegate: self)
        
        let navBarOnModal: UINavigationController = UINavigationController(rootViewController: alertConfigurationBuild)
        navBarOnModal.modalPresentationStyle = .overFullScreen
        navigationController?.present(navBarOnModal, animated: false)
    }
}

// MARK: - AlertServiceViewControllerDelegate

extension ServiceDetailViewController: AlertServiceViewControllerDelegate {
    func cancelCard(value: Bool) {
        serviceDetailView.stackViewService.isHidden = value
        serviceInteractorLogic.removeDataSave()
        delegate?.cancelService(value: value)
    }
}

// MARK: - ServiceDetailViewControllerDelgateLogic

extension ServiceDetailViewController: ServiceDetailViewControllerDelgateLogic {
    func passServiceDetail(model: ServiceDetailModel) {
        serviceDetailView.setupDate(setup: model)
        serviceDetailView.serviceDetailCardView.setupDate(setup: model)
    }
}

//
//  ServiceDetailViewController.swift
//  PoliServices
//
//  Created by Douglas  Rodrigues  on 09/03/23.
//

import UIKit

protocol ServiceDetailViewControllerDelgate: AnyObject {
    func cancelService(value: Bool)
}

class ServiceDetailViewController: UIViewController {
    
    // MARK: - Properties
    
    let serviceDetailView = ServiceDetailView()
    let viewModel: ServiceDetailViewModel
    
    weak var delegate: ServiceDetailViewControllerDelgate?
    
    init(viewModel: ServiceDetailViewModel) {
        self.viewModel = viewModel
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
        
        viewModel.setupServiceName()
        viewModel.setupStartDate()
        viewModel.setupStartHour()
        viewModel.setupFinishDate()
        viewModel.setupFinishHour()
        viewModel.setupRequestDate()
        viewModel.setupColorIcon()
        viewModel.setupDesabilityButton()
        
        serviceDetailView.setupDate(setup: viewModel)
    }
}

// MARK: - ServiceDetailViewDelegate

extension ServiceDetailViewController: ServiceDetailViewDelegate {
    func clickButton() {
        let service = ReasonServiceService()
        let viewModel = AlertServiceViewModel(service: service)
        let recipe = AlertServiceViewController(viewModel: viewModel)
        recipe.delegate = self
        let navBarOnModal: UINavigationController = UINavigationController(rootViewController: recipe)
        navBarOnModal.modalPresentationStyle = .overFullScreen
        navigationController?.present(navBarOnModal, animated: false)
    }
}

extension ServiceDetailViewController: AlertServiceViewControllerDelegate {
    func cancelCard(value: Bool) {
        serviceDetailView.stackViewService.isHidden = value
        delegate?.cancelService(value: value)
    }
}






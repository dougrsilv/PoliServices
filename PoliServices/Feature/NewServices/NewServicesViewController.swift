//
//  NewServicesViewController.swift
//  PoliServices
//
//  Created by Douglas  Rodrigues  on 01/03/23.
//

import UIKit

protocol NewServicesViewControllerLogic: AnyObject {
    func servicesData(data: [Data])
}

class NewServicesViewController: UICollectionViewController {
    
    // MARK: - Properties
    
    private let newServicesView = NewServicesView()
    private let newServicesInteractor: NewServicesInteractorLogic
    
    init(newServicesInteractor: NewServicesInteractorLogic) {
        self.newServicesInteractor = newServicesInteractor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = newServicesView
    }
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newServicesView.delegate = self
        newServicesInteractor.buscarService()
        
        title = "Novo Serviço"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelClicked))
        view.backgroundColor = UIColor(red: 0.925, green: 0.925, blue: 0.925, alpha: 1)
    }
    
    // MARK: - Fuctions
    
    @objc func cancelClicked() {
        dismiss(animated: true)
    }
}

extension NewServicesViewController: NewServicesViewDelegate {
    func typeService(service: String, duration: Int, color: String) {
        let viewModel = SchedulingServicesViewModel(name: service,
                                                    duration: duration,
                                                    color: color)
        let schedulingServicesViewController = SchedulingServicesViewController(viewModel: viewModel)
        navigationController?.pushViewController(schedulingServicesViewController, animated: true)
    }
}

extension NewServicesViewController: NewServicesViewControllerLogic {
    func servicesData(data: [Data]) {
        newServicesView.setupData(data: data)
    }
}

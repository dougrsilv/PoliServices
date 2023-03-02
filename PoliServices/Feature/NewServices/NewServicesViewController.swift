//
//  NewServicesViewController.swift
//  PoliServices
//
//  Created by Douglas  Rodrigues  on 01/03/23.
//

import UIKit

class NewServicesViewController: UICollectionViewController {
    
    // MARK: - Properties
    
    let newServicesView = NewServicesView()
    
    override func loadView() {
        view = newServicesView
    }
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newServicesView.delegate = self
        
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
    func typeService(service: String) {
        let viewModel = SchedulingServicesViewModel(name: service)
        let schedulingServicesViewController = SchedulingServicesViewController(services: viewModel)
        navigationController?.pushViewController(schedulingServicesViewController, animated: true)
    }
}

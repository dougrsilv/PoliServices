//
//  NewServicesViewController.swift
//  PoliServices
//
//  Created by Douglas  Rodrigues  on 01/03/23.
//

import UIKit

class NewServicesViewController: UICollectionViewController {
    
    // MARK: - Properties
    
    private let newServicesView = NewServicesView()
    private let viewModel: NewServicesViewModel
    
    init(viewModel: NewServicesViewModel) {
        self.viewModel = viewModel
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
        
        title = "Novo Serviço"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelClicked))
        view.backgroundColor = UIColor(red: 0.925, green: 0.925, blue: 0.925, alpha: 1)
        bindSetupData()
    }
    
    // MARK: - Fuctions
    
    func bindSetupData() {
        viewModel.buscarService { [weak self] service in
            guard let self = self else { return }
            switch service {
            case let .failure(erro):
                print(erro)
            case .success(_):
                self.newServicesView.data = self.viewModel.serviceViewModel
                self.newServicesView.collectionView.reloadData()
                self.newServicesView.activity.stopAnimating()
            }
        }
    }
    
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

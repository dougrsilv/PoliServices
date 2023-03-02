//
//  SchedulingServicesViewController.swift
//  PoliServices
//
//  Created by Douglas  Rodrigues  on 02/03/23.
//

import UIKit

class SchedulingServicesViewController: UIViewController {
    
    // MARK: - Properties
    
    let schedulingServicesView = SchedulingServicesView()
    let services: SchedulingServicesViewModel
    
    // MARK: - Lifecycle
    
    init(services: SchedulingServicesViewModel) {
        self.services = services
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = schedulingServicesView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Novo Serviço"
        let backButton = UIBarButtonItem()
        backButton.title = title
        navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveClicked))
    }
    
    @objc func saveClicked() {
        UserDefaults.standard.set(schedulingServicesView.datePicker.date.timeIntervalSince1970, forKey: "service_date")
        UserDefaults.standard.set(services.name, forKey: "service_name")
        dismiss(animated: true)
    }
}
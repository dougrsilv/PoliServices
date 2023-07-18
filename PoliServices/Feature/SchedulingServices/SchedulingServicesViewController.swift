//
//  SchedulingServicesViewController.swift
//  PoliServices
//
//  Created by Douglas  Rodrigues  on 02/03/23.
//

import UIKit

protocol SchedulingServicesViewControllerLogic: AnyObject {
    func setupData(model: SchedulingModel)
}

class SchedulingServicesViewController: UIViewController {
    
    // MARK: - Properties
    
    private let schedulingServicesView = SchedulingServicesView()
    private let  schedulingServicesInteractorLogic: SchedulingServicesInteractorLogic
    
    // MARK: - Lifecycle
    
    init(schedulingServicesInteractorLogic: SchedulingServicesInteractorLogic) {
        self.schedulingServicesInteractorLogic = schedulingServicesInteractorLogic
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
        schedulingServicesInteractorLogic.checkForPermission()
        schedulingServicesInteractorLogic.activateDataSchedulingModel()
    }
    
    // MARK: - Fuctions
    
    @objc func saveClicked() {
        UserDefaults.standard.set(schedulingServicesView.datePicker.date.timeIntervalSince1970, forKey: "service_date")
        schedulingServicesInteractorLogic.saveDataScheduling()
        schedulingServicesInteractorLogic.scheduleNotificationTime()
        dismiss(animated: true)
    }
}

// MARK: - SchedulingServicesViewControllerLogic

extension SchedulingServicesViewController: SchedulingServicesViewControllerLogic {
    func setupData(model: SchedulingModel) {
        schedulingServicesView.setupData(setup: model)
    }
}

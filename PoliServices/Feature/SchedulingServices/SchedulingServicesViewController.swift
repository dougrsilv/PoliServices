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
    let viewModel: SchedulingServicesViewModel
    let viewModelHome = HomeServicesViewModel()
    
    // MARK: - Lifecycle
    
    init(viewModel: SchedulingServicesViewModel) {
        self.viewModel = viewModel
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
        schedulingServicesView.setupData(setup: viewModel)
    }
    
    // MARK: - Fuctions
    
    func hourStart() -> String {
        let date = Date()
        let df = DateFormatter()
        df.dateFormat = "h:mm a"
        df.locale = Locale(identifier: "en_US_POSIX")
        let dateString = df.string(from: date)
        return dateString
    }
    
    @objc func saveClicked() {
        UserDefaults.standard.set(schedulingServicesView.datePicker.date.timeIntervalSince1970, forKey: "service_date")
        UserDefaults.standard.set(viewModel.name, forKey: "service_name")
        UserDefaults.standard.set(viewModel.color, forKey: "service_color")
        let start = hourStart()
        UserDefaults.standard.set(start, forKey: "service_hour_start")
        dismiss(animated: true)
    }
}

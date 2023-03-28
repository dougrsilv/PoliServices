//
//  HomeServicesViewController.swift
//  PoliServices
//
//  Created by Douglas  Rodrigues  on 28/02/23.
//

import UIKit
import UserNotifications

class HomeServicesViewController: UIViewController {
    
    // MARK: - Properties
    
    private let homeServiceView = HomeServicesView()
    private let viewModel: HomeServicesViewModel
    
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
        viewModel.delegate = self
        homeServiceView.subTitle.text = viewModel.dateAndHourNow()
        checkForPermission()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        view.backgroundColor = UIColor(red: 0.925, green: 0.925, blue: 0.925, alpha: 1)
        viewModel.setupService()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
        view.backgroundColor = UIColor(red: 0.925, green: 0.925, blue: 0.925, alpha: 1)
    }
    
    // MARK: - Functions
    
    private func checkForPermission() {
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.getNotificationSettings { settings in
            switch settings.authorizationStatus {
            case .authorized:
                return
            case .denied:
                return
            case .notDetermined:
                notificationCenter.requestAuthorization(options: [.alert, .sound]) { didAllow, error in
                    if didAllow {
                        self.dispatchNotification(hour: "", minute: "")
                    }
                }
            default:
                return
            }
        }
    }
    
    private func dispatchNotification(hour: String, minute: String) {
        let identifier = "my-alert"
        let title = "Agendamento"
        let body = "Falta 15 minutos para o serviço"
        let hour = Int(hour)
        let minute = Int(minute)
        let isDaily = true

        let notificationCenter = UNUserNotificationCenter.current()
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = .default

        let calendar = Calendar.current
        var dateComponents = DateComponents(calendar: calendar, timeZone: TimeZone.current)
        dateComponents.hour = hour
        dateComponents.minute = minute

        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: isDaily)
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        notificationCenter.removePendingNotificationRequests(withIdentifiers: [identifier])
        notificationCenter.add(request)
    }
    
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
        let newServicesViewModel = NewServicesViewModel(service: newServicesService)
        let recipe = NewServicesViewController(viewModel: newServicesViewModel)
        let navBarOnModal: UINavigationController = UINavigationController(rootViewController: recipe)
        navBarOnModal.modalPresentationStyle = .fullScreen
        navigationController?.present(navBarOnModal, animated: true)
    }
}

// MARK: - HomeServicesViewModelDelegate

extension HomeServicesViewController: HomeServicesViewModelDelegate {
    func hourAndMinuteNotice(hour: String, minute: String) {
        dispatchNotification(hour: hour, minute: minute)
    }
    
    func onStartDataHomeService(model: HomeModel) {
        homeServiceView.setParameter(model: model)
    }
    
    func hidesTimerCard(bool: Bool) {
        homeServiceView.setParameterHiden(values: bool)
    }
}

// MARK: - ServiceDetailViewControllerDelgate

extension HomeServicesViewController: ServiceDetailViewControllerDelgate {
    func cancelService(value: Bool) {
        homeServiceView.setParameterHiden(values: !value)
    }
}

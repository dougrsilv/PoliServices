//
//  AlertServiceConfiguration.swift
//  PoliServices
//
//  Created by Douglas  Rodrigues  on 30/07/23.
//

import UIKit

class AlertServiceConfiguration {
    
    func build(service: ReasonServiceServiceProtocol,
               postService: PostAnalitcsService,
               delegate: AlertServiceViewControllerDelegate) -> UIViewController {
        let alertServicePresenter = AlertServicePresenter()
        let alertServiceInteractor = AlertServiceInteractor(alertServicePresenterLogic: alertServicePresenter, service: service, postService: postService)
        let alertServiceViewController = AlertServiceViewController(alertServiceInteractor: alertServiceInteractor)
        alertServiceViewController.delegate = delegate
        alertServicePresenter.alertServiceViewControllerLogic = alertServiceViewController
        return alertServiceViewController
    }
}

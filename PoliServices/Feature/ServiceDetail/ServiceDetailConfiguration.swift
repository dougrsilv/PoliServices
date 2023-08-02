//
//  ServiceDetailConfiguration.swift
//  PoliServices
//
//  Created by Douglas  Rodrigues  on 31/07/23.
//

import UIKit

class ServiceDetailConfiguration {
    
    func build(delegate: ServiceDetailViewControllerDelgate?) -> UIViewController {
        let presenter = ServiceDetailPresenter()
        let interactor = ServiceDetailInteractor(serviceDetailPresenterLogic: presenter)
        let viewController = ServiceDetailViewController(serviceInteractorLogic: interactor)
        viewController.delegate = delegate
        presenter.serviceDetailViewControllerDelgateLogic = viewController
        return viewController
    }
}

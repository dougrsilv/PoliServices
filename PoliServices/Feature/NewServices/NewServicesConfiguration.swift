//
//  NewServicesConfiguration.swift
//  PoliServices
//
//  Created by Douglas  Rodrigues  on 16/07/23.
//

import UIKit

class NewServicesConfiguration {
    
    func build(service: NewServicesServiceProtocol) -> UIViewController {
        let newServicesPresenter = NewServicesPresenter()
        let newServicesInteractor = NewServicesInteractor(newServicesPresenter: newServicesPresenter, service: service)
        let newServicesViewController = NewServicesViewController(newServicesInteractor: newServicesInteractor)
        newServicesPresenter.newServicesViewController = newServicesViewController
        return newServicesViewController
    }
}

//
//  NewServicesPresenter.swift
//  PoliServices
//
//  Created by Douglas  Rodrigues  on 16/07/23.
//

import UIKit

protocol NewServicesPresenterLogic {
    func byPassViewModelData(data: [Data])
    func errorData(error: NewServiceError)
}

class NewServicesPresenter: NewServicesPresenterLogic {
   
    weak var newServicesViewController: NewServicesViewControllerLogic?
    
    func byPassViewModelData(data: [Data]) {
        newServicesViewController?.servicesData(data: data)
    }
    
    func errorData(error: NewServiceError) {
        print(error)
    }
}

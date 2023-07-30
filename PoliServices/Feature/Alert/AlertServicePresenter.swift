//
//  AlertServicePresenter.swift
//  PoliServices
//
//  Created by Douglas  Rodrigues  on 30/07/23.
//

import Foundation

protocol AlertServicePresenterLogic {
    func successDataTransaction(data: [ReasonModel])
    func errorDataTransaction()
    func succssOrErrorReturnPost(result: Bool)
}

class AlertServicePresenter: AlertServicePresenterLogic {
   
    weak var alertServiceViewControllerLogic: AlertServiceViewControllerLogic?
    
    func successDataTransaction(data: [ReasonModel]) {
        alertServiceViewControllerLogic?.successDataView(data: data)
    }
    
    func errorDataTransaction() {
        alertServiceViewControllerLogic?.errorDataView()
    }
    
    func succssOrErrorReturnPost(result: Bool) {
        alertServiceViewControllerLogic?.returnPostCardView(result: result)
    }
    
}

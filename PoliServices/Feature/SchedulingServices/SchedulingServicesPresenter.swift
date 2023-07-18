//
//  SchedulingServicesPresenter.swift
//  PoliServices
//
//  Created by Douglas  Rodrigues  on 16/07/23.
//

import Foundation

protocol SchedulingServicesPresenterLogic {
    func byPassScheduling(model: SchedulingModel)
}

class SchedulingServicesPresenter: SchedulingServicesPresenterLogic {
 
    weak var schedulingServicesViewController: SchedulingServicesViewControllerLogic?
    
    func byPassScheduling(model: SchedulingModel) {
        schedulingServicesViewController?.setupData(model: model)
    }
}

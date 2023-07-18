//
//  SchedulingServicesConfiguration.swift
//  PoliServices
//
//  Created by Douglas  Rodrigues  on 16/07/23.
//

import UIKit

class SchedulingServicesConfiguration {
    
    func build(name: String,
               duration: Int,
               color: String) -> UIViewController {
        let schedulingServicesPresenter = SchedulingServicesPresenter()
        let schedulingServicesInteractor = SchedulingServicesInteractor(schedulingServicesPresenter: schedulingServicesPresenter,
                                                                        name: name,
                                                                        duration: duration,
                                                                        color: color)
        let schedulingServicesViewController = SchedulingServicesViewController(schedulingServicesInteractorLogic: schedulingServicesInteractor)
        schedulingServicesPresenter.schedulingServicesViewController = schedulingServicesViewController
        return schedulingServicesViewController
    }
}

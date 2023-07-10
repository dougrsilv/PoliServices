//
//  HomeConfiguration.swift
//  PoliServices
//
//  Created by Douglas  Rodrigues  on 09/07/23.
//

import UIKit

class HomeConfiguration {
    
    func build() -> UIViewController {
        let homePresenter = HomePresenter()
        let homeInteractor = HomeInteractor(homePresenter: homePresenter)
        let homeServicesViewController = HomeServicesViewController(homeInteractor: homeInteractor)
        homePresenter.homeServiceViewControllerLogic = homeServicesViewController
        return homeServicesViewController
    }
}

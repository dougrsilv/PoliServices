//
//  HomePresenter.swift
//  PoliServices
//
//  Created by Douglas  Rodrigues  on 09/07/23.
//

import UIKit

protocol HomePresenterLogic {
    func hidesTimerCard(bool: Bool)
    func onStartDataHomeService(model: HomeModel)
    func dataHourNow(data: Date)
}

class HomePresenter: HomePresenterLogic {
    
    weak var homeServiceViewControllerLogic: HomeServicesViewControllerLogic?
    
    func hidesTimerCard(bool: Bool) {
        homeServiceViewControllerLogic?.hidesTimerCardResults(bool: bool)
    }
    
    func onStartDataHomeService(model: HomeModel) {
        homeServiceViewControllerLogic?.onStartDataHomeServiceResults(model: model)
    }
    
    func dataHourNow(data: Date) {
        let dateLabel = data.formatted(
            date: .long,
            time: .omitted
        )
        homeServiceViewControllerLogic?.dateAndHourNowFormated(data: dateLabel)
    }
}

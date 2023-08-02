//
//  ServiceDetailInteractor.swift
//  PoliServices
//
//  Created by Douglas  Rodrigues  on 31/07/23.
//

import Foundation

protocol ServiceDetailInteractorLogic {
    func saveDataServices()
    func removeDataSave()
}

class ServiceDetailInteractor: ServiceDetailInteractorLogic {
    
    private let serviceDetailPresenterLogic: ServiceDetailPresenterLogic
    
    private var userDefaults: UserDefaults
    
    init(serviceDetailPresenterLogic: ServiceDetailPresenterLogic, userDefaults: UserDefaults = .standard) {
        self.serviceDetailPresenterLogic = serviceDetailPresenterLogic
        self.userDefaults = userDefaults
    }
    
    func saveDataServices() {
        serviceDetailPresenterLogic.byPassInformationService(serviceName: userDefaults.string(forKey: "service_name") ?? "",
                                                             serviceDateInteger: userDefaults.integer(forKey: "service_date"),
                                                             hourStart: userDefaults.string(forKey: "service_hour_start") ?? "",
                                                             colorIconSave: userDefaults.string(forKey: "service_color") ?? "",
                                                             desabilyButton: userDefaults.string(forKey: "service_Desabilita") ?? "")
    }
    
    func removeDataSave() {
        UserDefaults.standard.removeObject(forKey: "service_date")
        UserDefaults.standard.removeObject(forKey: "service_name")
        UserDefaults.standard.removeObject(forKey: "service_color")
        UserDefaults.standard.removeObject(forKey: "service_hour_start")
        UserDefaults.standard.removeObject(forKey: "service_Desabilita")
    }
}

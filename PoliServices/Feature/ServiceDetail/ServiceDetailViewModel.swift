//
//  ServiceDetailViewModel.swift
//  PoliServices
//
//  Created by Douglas  Rodrigues  on 12/03/23.
//

import Foundation

class ServiceDetailViewModel {
    
    var serviceName: String = ""
    var startDate: String = ""
    var startHour: String = ""
    var finishDate: String = ""
    var finishHour: String = ""
    var requestDate: String = ""
    var colorIcon: String = ""
    var desabilityButton: String = ""
    let dateFormatter = DateFormatter()
    
    let serviceNameRec = UserDefaults.standard.string(forKey: "service_name")
    let serviceDateInteger = UserDefaults.standard.integer(forKey: "service_date")
    let hourStart = UserDefaults.standard.string(forKey: "service_hour_start")
    let colorIconSave = UserDefaults.standard.string(forKey: "service_color")
    let desabily = UserDefaults.standard.string(forKey: "service_Desabilita")
    
    // Nome do Serviço
    func setupServiceName() {
        self.serviceName = serviceNameRec ?? ""
    }
    
    // Start Date
    func setupStartDate() {
        let serviceDate = Date(timeIntervalSince1970: TimeInterval(serviceDateInteger))
        startDate = serviceDate.formatted(
            date: .complete,
            time: .omitted
        )
    }
    
    // Start Time
    func setupStartHour() {
        startHour = hourStart ?? ""
    }
    
    // Finish Date
    func setupFinishDate() {
        let serviceDate = Date(timeIntervalSince1970: TimeInterval(serviceDateInteger))
        finishDate = serviceDate.formatted(
            date: .complete,
            time: .omitted
        )
    }
    
    // Finish Time
    func setupFinishHour() {
        let serviceDate = Date(timeIntervalSince1970: TimeInterval(serviceDateInteger))
        dateFormatter.dateFormat = "hh:mm a"
        let date = dateFormatter.string(from: serviceDate)
        finishHour = date
    }
    
    // Request Date
    func setupRequestDate() {
        let serviceDate = Date(timeIntervalSince1970: TimeInterval(serviceDateInteger))
        requestDate = serviceDate.formatted(
            date: .complete,
            time: .omitted
        )
    }
    
    // Icon Color
    func setupColorIcon() {
        colorIcon = colorIconSave ?? ""
    }
    
    // Desability Button
    func setupDesabilityButton() {
        desabilityButton = desabily ?? ""
    }
}

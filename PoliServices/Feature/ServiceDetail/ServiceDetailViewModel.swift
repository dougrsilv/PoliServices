//
//  ServiceDetailViewModel.swift
//  PoliServices
//
//  Created by Douglas  Rodrigues  on 12/03/23.
//

import Foundation

class ServiceDetailViewModel {
    
    var serviceName: String
    var startHour: String
    var colorIcon: String
    var desabilityButton: String
    var serviceDateInteger: Int
    let dateFormatter = DateFormatter()
    
    init(serviceName: String, hourStart: String,
         serviceDateInteger: Int,
         colorIcon: String,
         desabilityButton: String) {
        self.serviceName = serviceName
        self.startHour = hourStart
        self.serviceDateInteger = serviceDateInteger
        self.colorIcon = colorIcon
        self.desabilityButton = desabilityButton
    }
    
    func setupStartDate() -> String {
        let serviceDate = Date(timeIntervalSince1970: TimeInterval(serviceDateInteger))
       let startDate = serviceDate.formatted(
            date: .complete,
            time: .omitted
        )
        return startDate
    }
    
    func setupFinishDate() -> String {
        let serviceDate = Date(timeIntervalSince1970: TimeInterval(serviceDateInteger))
        let finishDate = serviceDate.formatted(
            date: .complete,
            time: .omitted
        )
        return finishDate
    }
    
    func setupFinishHour() -> String {
        let serviceDate = Date(timeIntervalSince1970: TimeInterval(serviceDateInteger))
        dateFormatter.dateFormat = "hh:mm a"
        let date = dateFormatter.string(from: serviceDate)
        return date
    }
    
    func setupRequestDate() -> String {
        let serviceDate = Date(timeIntervalSince1970: TimeInterval(serviceDateInteger))
        let requestDate = serviceDate.formatted(
            date: .complete,
            time: .omitted
        )
        return requestDate
    }
}

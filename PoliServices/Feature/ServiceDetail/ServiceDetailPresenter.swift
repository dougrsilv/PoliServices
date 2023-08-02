//
//  ServiceDetailPresenter.swift
//  PoliServices
//
//  Created by Douglas  Rodrigues  on 31/07/23.
//

import Foundation

protocol ServiceDetailPresenterLogic {
    func byPassInformationService(serviceName: String,
                                  serviceDateInteger: Int,
                                  hourStart: String,
                                  colorIconSave: String,
                                  desabilyButton: String)
}

class ServiceDetailPresenter: ServiceDetailPresenterLogic {
    
    weak var serviceDetailViewControllerDelgateLogic: ServiceDetailViewControllerDelgateLogic?
    
    private let dateFormatter = DateFormatter()
    private var serviceDateInteger: Int = 0
    
    func byPassInformationService(serviceName: String, serviceDateInteger: Int, hourStart: String, colorIconSave: String, desabilyButton: String) {
        self.serviceDateInteger = serviceDateInteger
        
        let model = ServiceDetailModel(serviceName: serviceName ,
                                       hourStart: hourStart ,
                                       colorIconSave: colorIconSave ,
                                       desabilyButton: desabilyButton ,
                                       startDate: formatStartDate(),
                                       finishDate: formatFinishDate(),
                                       finishHour: formatFinishHour(),
                                       fequestDate: formatRequestDate())
        
        serviceDetailViewControllerDelgateLogic?.passServiceDetail(model: model)
    }
    
    private func formatStartDate() -> String {
        let serviceDate = Date(timeIntervalSince1970: TimeInterval(serviceDateInteger))
       let startDate = serviceDate.formatted(
            date: .complete,
            time: .omitted
        )
        return startDate
    }
    
    private func formatFinishDate() -> String {
        let serviceDate = Date(timeIntervalSince1970: TimeInterval(serviceDateInteger))
        let finishDate = serviceDate.formatted(
            date: .complete,
            time: .omitted
        )
        return finishDate
    }
    
    private func formatFinishHour() -> String {
        let serviceDate = Date(timeIntervalSince1970: TimeInterval(serviceDateInteger))
        dateFormatter.dateFormat = "hh:mm a"
        let date = dateFormatter.string(from: serviceDate)
        return date
    }
    
    private func formatRequestDate() -> String {
        let serviceDate = Date(timeIntervalSince1970: TimeInterval(serviceDateInteger))
        let requestDate = serviceDate.formatted(
            date: .complete,
            time: .omitted
        )
        return requestDate
    }
}

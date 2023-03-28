//
//  ServiceDetailViewModel.swift
//  PoliServices
//
//  Created by Douglas  Rodrigues  on 12/03/23.
//

import Foundation

protocol ServiceDetailViewModelDelegate: AnyObject {
    func setupDataServiceModel(model: ServiceDetailModel)
}

class ServiceDetailViewModel {
    
    private let dateFormatter = DateFormatter()
    private var serviceDetailModel: ServiceDetailModel?
    weak var delegate: ServiceDetailViewModelDelegate?
    
    private let serviceName = UserDefaults.standard.string(forKey: "service_name")
    private let serviceDateInteger = UserDefaults.standard.integer(forKey: "service_date")
    private let hourStart = UserDefaults.standard.string(forKey: "service_hour_start")
    private let colorIconSave = UserDefaults.standard.string(forKey: "service_color")
    private let desabilyButton = UserDefaults.standard.string(forKey: "service_Desabilita")
    
    func bindDataServiceDetail() {
        let model = ServiceDetailModel(serviceName: serviceName ?? "",
                                       hourStart: hourStart ?? "",
                                       colorIconSave: colorIconSave ?? "",
                                       desabilyButton: desabilyButton ?? "",
                                       startDate: formatStartDate(),
                                       finishDate: formatFinishDate(),
                                       finishHour: formatFinishHour(),
                                       fequestDate: formatRequestDate())
        
        self.serviceDetailModel = model
        delegate?.setupDataServiceModel(model: model)
    }
    
    func removeDataSave() {
        UserDefaults.standard.removeObject(forKey: "service_date")
        UserDefaults.standard.removeObject(forKey: "service_name")
        UserDefaults.standard.removeObject(forKey: "service_color")
        UserDefaults.standard.removeObject(forKey: "service_hour_start")
        UserDefaults.standard.removeObject(forKey: "service_Desabilita")
    }
}

private extension ServiceDetailViewModel {
    func formatStartDate() -> String {
        let serviceDate = Date(timeIntervalSince1970: TimeInterval(serviceDateInteger))
       let startDate = serviceDate.formatted(
            date: .complete,
            time: .omitted
        )
        return startDate
    }
    
    func formatFinishDate() -> String {
        let serviceDate = Date(timeIntervalSince1970: TimeInterval(serviceDateInteger))
        let finishDate = serviceDate.formatted(
            date: .complete,
            time: .omitted
        )
        return finishDate
    }
    
    func formatFinishHour() -> String {
        let serviceDate = Date(timeIntervalSince1970: TimeInterval(serviceDateInteger))
        dateFormatter.dateFormat = "hh:mm a"
        let date = dateFormatter.string(from: serviceDate)
        return date
    }
    
    func formatRequestDate() -> String {
        let serviceDate = Date(timeIntervalSince1970: TimeInterval(serviceDateInteger))
        let requestDate = serviceDate.formatted(
            date: .complete,
            time: .omitted
        )
        return requestDate
    }
}

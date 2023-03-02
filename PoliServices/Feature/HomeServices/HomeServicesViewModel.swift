//
//  HomeServicesViewModel.swift
//  PoliServices
//
//  Created by Douglas  Rodrigues  on 02/03/23.
//

import Foundation
 
protocol HomeServicesViewModelDelegate: AnyObject {
    func timerBool(bool: Bool)
}

class HomeServicesViewModel {
    
    weak var delegate: HomeServicesViewModelDelegate?
    
    private var timer: Timer?
    let currentDate = Date()
    var hidesCard: Bool = false
    var serviceNameCard: String = ""
    var serviceDateCard: String = ""
    
    func setupService() {
        let currentDate = Date()
        let serviceDateInteger = UserDefaults.standard.integer(forKey: "service_date")
        let serviceDate = Date(timeIntervalSince1970: TimeInterval(serviceDateInteger))
        let hasService = serviceDate >= currentDate
        if hasService {
            hidesCard = hasService
            let serviceName = UserDefaults.standard.string(forKey: "service_name")

            serviceNameCard = serviceName ?? ""
            serviceDateCard = serviceDate.formatted(
                date: .numeric,
                time: .shortened
            )
        }else{
            hidesCard = hasService
            delegate?.timerBool(bool: hasService)
            UserDefaults.standard.removeObject(forKey: "service_date")
            UserDefaults.standard.removeObject(forKey: "service_name")
        }       
    }
    
    func dateAndHourNow() -> String {
        let dateLabel = currentDate.formatted(
            date: .long,
            time: .omitted
        )
        return dateLabel
    }
    
    func initTimer(){
        let now: Date = Date()
        let calendar: Calendar = Calendar.current
        let currentSeconds: Int = calendar.component(.second, from: now)
        let timer = Timer(
            fire: now.addingTimeInterval(Double(60 - currentSeconds + 1)),
            interval: 60,
            repeats: true,
            block: { (t: Timer) in
                self.setupService()
            })
        RunLoop.main.add(timer, forMode: .default)
        self.timer = timer
    }
    
}

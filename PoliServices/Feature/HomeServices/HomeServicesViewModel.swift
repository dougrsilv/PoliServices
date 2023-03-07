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
    let currentDatet = Date()
    var hidesCard: Bool = false
    var serviceNameCard: String = ""
    var serviceDateCard: String = ""
    var colorCard: String = ""
    var dayAndHour: String = ""
    
    func setupService() {
        let currentDate = Date()
        let serviceDateInteger = UserDefaults.standard.integer(forKey: "service_date")
        let serviceDate = Date(timeIntervalSince1970: TimeInterval(serviceDateInteger))
        let hasService = serviceDate >= currentDate
        if hasService {
            hidesCard = hasService
            let serviceName = UserDefaults.standard.string(forKey: "service_name")
            let serviceColor = UserDefaults.standard.string(forKey: "service_color")

            serviceNameCard = serviceName ?? ""
            serviceDateCard = serviceDate.formatted(
                date: .numeric,
                time: .shortened
            )
            colorCard = serviceColor ?? ""
            calculateDays(from: currentDate, to: serviceDate)
        }else{
            hidesCard = hasService
            delegate?.timerBool(bool: hasService)
            UserDefaults.standard.removeObject(forKey: "service_date")
            UserDefaults.standard.removeObject(forKey: "service_name")
            UserDefaults.standard.removeObject(forKey: "service_color")
        }       
    }
    
    func dateAndHourNow() -> String {
        let dateLabel = currentDatet.formatted(
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
    
    func calculateDays(from lhs: Date, to rhs: Date) {
        let diffComponents = Calendar.current.dateComponents([.day, .hour, .minute, .second], from: lhs, to: rhs)
        guard let days = diffComponents.day else { return }
        guard let hours = diffComponents.hour else { return }
        guard let minutes = diffComponents.minute else { return }
        
        if days == 0 && hours >= 12 {
            dayAndHour = "Faltam menos de 1 dia"
        }
        else if days == 1 {
            dayAndHour = "Faltam 2 dias"
        }
        else if hours != 0 && minutes == 0 {
            dayAndHour = "Faltam \(String(describing: hours)) horas para o atendimento"
        }
        else if hours == 0 && minutes > 0 {
            dayAndHour = "Faltam \(String(describing: minutes)) minuto para o atendimento"
        }
        else if hours != 0 && minutes > 0 {
            dayAndHour = "Faltam \(String(describing: hours)) e \(String(describing: minutes)) minutos para o atendimento"
        }
    }
}

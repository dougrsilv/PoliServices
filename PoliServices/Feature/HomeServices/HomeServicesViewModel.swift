//
//  HomeServicesViewModel.swift
//  PoliServices
//
//  Created by Douglas  Rodrigues  on 02/03/23.
//

import Foundation
 
protocol HomeServicesViewModelDelegate: AnyObject {
    func timerBool(bool: Bool)
    func timerAlert(bool: Bool)
    func timerEnable(bool: Bool)
    func onStartDataHomeService(model: HomeModel)
}

class HomeServicesViewModel {
    
    weak var delegate: HomeServicesViewModelDelegate?
    private var homeModel: HomeModel?
    
    //private var timer: Timer?
    //let currentDatet = Date()
    //var hidesCard: Bool = false
    //var serviceNameCard: String = ""
    //var serviceDateCard: String = ""
    //var colorCard: String = ""
    //var dayAndHour: String = ""
    //var booleanTeste: Bool = false
    
    func setupService() {
        let currentDate = Date()
        let serviceDateInteger = UserDefaults.standard.integer(forKey: "service_date")
        let serviceDate = Date(timeIntervalSince1970: TimeInterval(serviceDateInteger))
        let hasService = serviceDate >= currentDate
        if hasService {
            guard var model = homeModel else { return }
            
            model.hidesCard = hasService
            let serviceName = UserDefaults.standard.string(forKey: "service_name")
            let serviceColor = UserDefaults.standard.string(forKey: "service_color")

            model.serviceNameCard = serviceName ?? ""
            model.serviceDateCard = serviceDate.formatted(
                date: .numeric,
                time: .shortened
            )
            model.colorCard = serviceColor ?? ""
            calculateDays(from: currentDate, to: serviceDate)
            calculeTime(from: currentDate, to: serviceDate)
            calculeTimeEnable(from: currentDate, to: serviceDate)
            delegate?.onStartDataHomeService(model: model)
        }else{
            homeModel?.hidesCard = hasService
            delegate?.timerBool(bool: hasService)
            UserDefaults.standard.removeObject(forKey: "service_date")
            UserDefaults.standard.removeObject(forKey: "service_name")
            UserDefaults.standard.removeObject(forKey: "service_color")
            UserDefaults.standard.removeObject(forKey: "service_Desabilita")
        }       
    }
    
    func dateAndHourNow() -> String {
        guard let dateLabel = homeModel?.currentDatet.formatted(
            date: .long,
            time: .omitted
        ) else { return "" }
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
            block: { [weak self] (t: Timer) in
                self?.setupService()
            })
        RunLoop.main.add(timer, forMode: .default)
        self.homeModel?.timer = timer
    }
    
    func calculateDays(from lhs: Date, to rhs: Date) {
        let diffComponents = Calendar.current.dateComponents([.day, .hour, .minute, .second], from: lhs, to: rhs)
        guard let days = diffComponents.day else { return }
        guard let hours = diffComponents.hour else { return }
        guard let minutes = diffComponents.minute else { return }
        
        if days == 0 && hours >= 12 {
            homeModel?.dayAndHour = "Faltam menos de 1 dia"
        }
        else if days == 1 {
            homeModel?.dayAndHour = "Faltam 2 dias"
        }
        else if hours != 0 && minutes == 0 {
            homeModel?.dayAndHour = "Faltam \(String(describing: hours)) horas para o atendimento"
        }
        else if hours == 0 && minutes > 0 {
            homeModel?.dayAndHour = "Faltam \(String(describing: minutes)) minuto para o atendimento"
        }
        else if hours != 0 && minutes > 0 {
            homeModel?.dayAndHour = "Faltam \(String(describing: hours)) e \(String(describing: minutes)) minutos para o atendimento"
        }
    }
    
    func calculeTime(from lhs: Date, to rhs: Date) {
        let diffComponents = Calendar.current.dateComponents([.day, .hour, .minute, .second], from: lhs, to: rhs)
        guard let minutes = diffComponents.minute else { return }
        
        if minutes == 15 {
            homeModel?.booleanTeste = true
            delegate?.timerAlert(bool: true)
        }
    }
    
    func calculeTimeEnable(from lhs: Date, to rhs: Date) {
        let diffComponents = Calendar.current.dateComponents([.day, .hour, .minute, .second], from: lhs, to: rhs)
        guard let hours = diffComponents.hour else { return }
        //guard let minutes = diffComponents.minute else { return }
        
        if hours == 2 {
            homeModel?.booleanTeste = true
            delegate?.timerEnable(bool: true)
        }
    }
    
    func removeDataSave() {
        UserDefaults.standard.removeObject(forKey: "service_date")
        UserDefaults.standard.removeObject(forKey: "service_name")
        UserDefaults.standard.removeObject(forKey: "service_color")
        UserDefaults.standard.removeObject(forKey: "service_hour_start")
        UserDefaults.standard.removeObject(forKey: "service_Desabilita")
    }
}

//
//  HomeInteractor.swift
//  PoliServices
//
//  Created by Douglas  Rodrigues  on 09/07/23.
//

import UIKit

protocol HomeInteractorLogic {
    func setupService()
    func initTimer()
    func dateAndHourNow() -> String
    func captureDateAndHour()
}

class HomeInteractor: HomeInteractorLogic {
    
    private let homePresenter: HomePresenterLogic
    
    init(homePresenter: HomePresenterLogic) {
        self.homePresenter = homePresenter
    }
    
    private var homeModel: HomeModel?
    private let currentDate = Date()
    
    func setupService() {
        let currentDate = Date()
        let serviceDateInteger = UserDefaults.standard.integer(forKey: "service_date")
        let serviceDate = Date(timeIntervalSince1970: TimeInterval(serviceDateInteger))
        let hasService = serviceDate >= currentDate
        if hasService {
            let serviceName = UserDefaults.standard.string(forKey: "service_name")
            let serviceColor = UserDefaults.standard.string(forKey: "service_color")
            let dateFormat =  serviceDate.formatted(
                date: .numeric,
                time: .shortened
              )
     
            disableServiceCancelButton(from: currentDate, to: serviceDate)
            
            let model = HomeModel(currentDatet: dateAndHourNow(),
                                  hidesCard: hasService,
                                  serviceNameCard: serviceName ?? "",
                                  serviceDateCard:dateFormat,
                                  colorCard: serviceColor ?? "",
                                  dayAndHour: messageCalculateCardServiceTime(from: currentDate, to: serviceDate))
            
            self.homeModel = model
            homePresenter.onStartDataHomeService(model: model)
        } else {
            homeModel?.hidesCard = hasService
            homePresenter.hidesTimerCard(bool: hasService)
            removeDataSave()
        }
    }
    
    func dateAndHourNow() -> String {
        let dateLabel = currentDate.formatted(
            date: .long,
            time: .omitted
        )
        return dateLabel
    }
    
    func captureDateAndHour() {
        homePresenter.dataHourNow(data: currentDate)
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
    }
    
    private func removeDataSave() {
        UserDefaults.standard.removeObject(forKey: "service_date")
        UserDefaults.standard.removeObject(forKey: "service_name")
        UserDefaults.standard.removeObject(forKey: "service_color")
        UserDefaults.standard.removeObject(forKey: "service_hour_start")
        UserDefaults.standard.removeObject(forKey: "service_Desabilita")
    }
    
    private func messageCalculateCardServiceTime(from lhs: Date, to rhs: Date) -> String {
        let diffComponents = Calendar.current.dateComponents([.day, .hour, .minute, .second], from: lhs, to: rhs)
        
        if let days = diffComponents.day,
           let hours = diffComponents.hour,
           let minutes = diffComponents.minute {
            
            if days == 0 && hours >= 12 {
               return "Faltam menos de 1 dia"
            }
            else if days == 1 {
               return "Faltam 2 dias"
            }
            else if hours != 0 && minutes == 0 {
                return "Faltam \(String(describing: hours)) horas para o atendimento"
            }
            else if hours == 0 && minutes > 0 {
                return "Faltam \(String(describing: minutes)) minuto para o atendimento"
            }
            else if hours != 0 && minutes > 0 {
                return "Faltam \(String(describing: hours)) e \(String(describing: minutes)) minutos para o atendimento"
            }
        }
        return ""
    }
    
    private func disableServiceCancelButton(from lhs: Date, to rhs: Date) {
        let diffComponents = Calendar.current.dateComponents([.day, .hour, .minute, .second], from: lhs, to: rhs)
        guard let hours = diffComponents.hour else { return }
        //guard let minutes = diffComponents.minute else { return }
        
        if hours == 2 {
            // VOLTER AO CÓDIGO
            //UserDefaults.standard.set(true, forKey: "service_Desabilita")
            // NÃO ESQUECER DE REMOVER
            UserDefaults.standard.set(false, forKey: "service_Desabilita")
        }
    }
}

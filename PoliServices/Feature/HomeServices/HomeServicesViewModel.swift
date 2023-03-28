//
//  HomeServicesViewModel.swift
//  PoliServices
//
//  Created by Douglas  Rodrigues  on 02/03/23.
//

import Foundation
import UserNotifications
 
protocol HomeServicesViewModelDelegate: AnyObject {
    func hidesTimerCard(bool: Bool)
    func onStartDataHomeService(model: HomeModel)
}

class HomeServicesViewModel {
    
    weak var delegate: HomeServicesViewModelDelegate?
    private var homeModel: HomeModel?
    private let currentDate = Date()
    
    func setupService() {
        let currentDate = Date()
        let serviceDateInteger = UserDefaults.standard.integer(forKey: "service_date")
        let serviceDate = Date(timeIntervalSince1970: TimeInterval(serviceDateInteger))
        let hasService = serviceDate >= currentDate
        dispatchNotification(hour: captureHourSchedule(date: serviceDate),
                             minute: captureMinuteSchedule(date: serviceDate))
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
            delegate?.onStartDataHomeService(model: model)
        } else {
            homeModel?.hidesCard = hasService
            delegate?.hidesTimerCard(bool: hasService)
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
    
    func removeDataSave() {
        UserDefaults.standard.removeObject(forKey: "service_date")
        UserDefaults.standard.removeObject(forKey: "service_name")
        UserDefaults.standard.removeObject(forKey: "service_color")
        UserDefaults.standard.removeObject(forKey: "service_hour_start")
        UserDefaults.standard.removeObject(forKey: "service_Desabilita")
    }
    
    func checkForPermission() {
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.getNotificationSettings { settings in
            switch settings.authorizationStatus {
            case .authorized:
                return
            case .denied:
                return
            case .notDetermined:
                notificationCenter.requestAuthorization(options: [.alert, .sound]) { didAllow, error in
                    if didAllow {
                        self.dispatchNotification(hour: "", minute: "")
                    }
                }
            default:
                return
            }
        }
    }
}

private extension HomeServicesViewModel {
    
    func messageCalculateCardServiceTime(from lhs: Date, to rhs: Date) -> String {
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
    
    func disableServiceCancelButton(from lhs: Date, to rhs: Date) {
        let diffComponents = Calendar.current.dateComponents([.day, .hour, .minute, .second], from: lhs, to: rhs)
        guard let hours = diffComponents.hour else { return }
        //guard let minutes = diffComponents.minute else { return }
        
        if hours == 2 {
            UserDefaults.standard.set(true, forKey: "service_Desabilita")
        }
    }
    
    func captureMinuteSchedule(date: Date) -> String {
        let calendar = Calendar.current
        let date = calendar.date(byAdding: .minute, value: -15, to: date)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss z"
        let dateString = dateFormatter.string(from: date ?? Date())
        
        let dateHour = dateFormatter.date(from: dateString) ?? Date()
        dateFormatter.dateFormat = "mm"
        let resultMinute = dateFormatter.string(from: dateHour)
        return resultMinute
    }
    
    func captureHourSchedule(date: Date) -> String {
        let calendar = Calendar.current
        let date = calendar.date(byAdding: .minute, value: -15, to: date)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss z"
        let dateString = dateFormatter.string(from: date ?? Date())
        
        let dateHour = dateFormatter.date(from: dateString) ?? Date()
        dateFormatter.dateFormat = "HH"
        let resulteHour = dateFormatter.string(from: dateHour)
        return resulteHour
    }
    
    private func dispatchNotification(hour: String, minute: String) {
        let identifier = "my-alert"
        let title = "Agendamento"
        let body = "Falta 15 minutos para o serviço"
        let hour = Int(hour)
        let minute = Int(minute)
        let isDaily = true

        let notificationCenter = UNUserNotificationCenter.current()
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = .default

        let calendar = Calendar.current
        var dateComponents = DateComponents(calendar: calendar, timeZone: TimeZone.current)
        dateComponents.hour = hour
        dateComponents.minute = minute

        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: isDaily)
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        notificationCenter.removePendingNotificationRequests(withIdentifiers: [identifier])
        notificationCenter.add(request)
    }
    
}

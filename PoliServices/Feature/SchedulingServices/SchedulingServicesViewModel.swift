//
//  SchedulingServicesViewModel.swift
//  PoliServices
//
//  Created by Douglas  Rodrigues  on 02/03/23.
//

import Foundation
import UserNotifications

class SchedulingServicesViewModel {
    
    let schedulingModel: SchedulingModel
    
    init(name: String, duration: Int, color: String) {
        let model = SchedulingModel(name: name,
                                    duration: duration,
                                    color: color)
        self.schedulingModel = model
    }
    
    private func hourStart() -> String {
        let date = Date()
        let df = DateFormatter()
        df.dateFormat = "h:mm a"
        df.locale = Locale(identifier: "en_US_POSIX")
        let dateString = df.string(from: date)
        return dateString
    }
    
    func saveDataScheduling() {
        let start = hourStart()
        UserDefaults.standard.set(schedulingModel.name, forKey: "service_name")
        UserDefaults.standard.set(schedulingModel.color, forKey: "service_color")
        UserDefaults.standard.set(start, forKey: "service_hour_start")
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
    
    func scheduleNotificationTime() {
        let serviceDateInteger = UserDefaults.standard.integer(forKey: "service_date")
        let serviceDate = Date(timeIntervalSince1970: TimeInterval(serviceDateInteger))
        dispatchNotification(hour: captureHourSchedule(date: serviceDate),
                             minute: captureMinuteSchedule(date: serviceDate))
    }
    
    private func captureMinuteSchedule(date: Date) -> String {
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
    
    private func captureHourSchedule(date: Date) -> String {
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

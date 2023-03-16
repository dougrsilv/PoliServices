//
//  SchedulingServicesViewModel.swift
//  PoliServices
//
//  Created by Douglas  Rodrigues  on 02/03/23.
//

import Foundation

class SchedulingServicesViewModel {
    
    var name: String
    var duration: Int
    var color: String
    
    init(name: String, duration: Int, color: String) {
        self.name = name
        self.duration = duration
        self.color = color
    }
    
    func hourStart() -> String {
        let date = Date()
        let df = DateFormatter()
        df.dateFormat = "h:mm a"
        df.locale = Locale(identifier: "en_US_POSIX")
        let dateString = df.string(from: date)
        return dateString
    }
    
    func saveDataScheduling() {
        let start = hourStart()
        UserDefaults.standard.set(name, forKey: "service_name")
        UserDefaults.standard.set(color, forKey: "service_color")
        UserDefaults.standard.set(start, forKey: "service_hour_start")
    }
}

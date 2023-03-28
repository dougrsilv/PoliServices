//
//  SchedulingServicesViewModel.swift
//  PoliServices
//
//  Created by Douglas  Rodrigues  on 02/03/23.
//

import Foundation

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
}

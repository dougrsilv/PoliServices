//
//  ServiceDetailService.swift
//  PoliServices
//
//  Created by Douglas  Rodrigues  on 14/03/23.
//

import Foundation

struct ServiceDetailService {
    
    let serviceNameRec = UserDefaults.standard.string(forKey: "service_name")
    let serviceDateInteger = UserDefaults.standard.integer(forKey: "service_date")
    let hourStart = UserDefaults.standard.string(forKey: "service_hour_start")
    let colorIconSave = UserDefaults.standard.string(forKey: "service_color")
    let desabily = UserDefaults.standard.string(forKey: "service_Desabilita")
    
}

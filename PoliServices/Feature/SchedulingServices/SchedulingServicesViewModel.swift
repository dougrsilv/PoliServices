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
    
}

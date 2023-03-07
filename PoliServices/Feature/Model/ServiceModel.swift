//
//  ServiceModel.swift
//  PoliServices
//
//  Created by Douglas  Rodrigues  on 04/03/23.
//

import Foundation

struct ServiceModel: Decodable {
    let success: Bool
    let data: [Data]
}

struct Data: Decodable {
    let id: Int
    let name: String
    let icon: String
    let color: String
    let duration: Int
}

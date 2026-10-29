//
//  Mission.swift
//  Moonshot
//
//  Created by Cauan de Jesus Nascimento de Morais on 28/10/26.
//

import Foundation

struct Mission: Codable, Identifiable {
    struct crewRole: Codable {
        let name: String
        let role: String
    }
    
    let id: Int
    let launchDate: Date?
    let crew: [crewRole]
    let description: String
    
    var displayName: String {
        "Appollo \(id)"
    }
    
    var image: String {
        "apollo\(id)"
    }
        
    var formattedDateLaunch: String {
        launchDate?.formatted(date: .abbreviated, time: .omitted) ?? "N/A"
    }
}

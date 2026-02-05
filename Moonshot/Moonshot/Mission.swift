//
//  Mission.swift
//  Moonshot
//
//  Created by niccho on 4/11/2025.
//

import Foundation

struct Mission: Codable, Identifiable, Hashable {
    struct CrewRole: Codable, Hashable {
        let name: String
        let role: String
    }

    let id: Int
    let crew: [CrewRole]
    let description: String
    let launchDate: Date?
    var imageName: String {
        "apollo\(self.id)"
    }
    
    var displayName: String {
        "Apollo \(self.id)"
    }
    
    var abbreviatedLaunchDate: String {
        launchDate?.formatted(date: .abbreviated, time: .omitted) ?? "N/A"
    }
    
    var fullLaunchDate: String {
        launchDate?.formatted(date:.complete, time: .omitted) ?? "N/A"
    }
}

//
//  User.swift
//  SwiftDataProject
//
//  Created by niccho on 12/11/2025.
//

import SwiftData
import SwiftUI

@Model
class User {
    var name: String = "Anonymous"
    var city: String = "Unknown"
    var joinDate: Date = Date.now
    
    @Relationship(deleteRule: .cascade) var jobs: [Job]? = [Job]()
    
    init(name: String, city: String, joinDate: Date) {
        self.name = name
        self.city = city
        self.joinDate = joinDate
    }
}

@Model
class Job {
    var name: String = "None"
    var priority: Int = 1
    var owner: User?

    init(name: String, priority: Int, owner: User? = nil) {
        self.name = name
        self.priority = priority
        self.owner = owner
    }
}

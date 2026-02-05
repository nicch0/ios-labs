//
//  Prospect.swift
//  HotProspects
//
//  Created by niccho on 25/11/2025.
//

import SwiftData

@Model
class Prospect {
    var name: String
    var emailAddress: String
    var isContacted: Bool

    init(name: String, emailAddress: String, isContacted: Bool) {
        self.name = name
        self.emailAddress = emailAddress
        self.isContacted = isContacted
    }

    static let examples = [
        Prospect(name: "Aaron", emailAddress: "aaron@aaron.com", isContacted: false),
        Prospect(name: "Thomas", emailAddress: "thomas@thomas.com", isContacted: false),
        Prospect(name: "Gowtham", emailAddress: "gowtham@gowtham.com", isContacted: false),
    ]
}

//
//  Resort.swift
//  SnowSeeker
//
//  Created by niccho on 12/12/2025.
//
import SwiftUI

struct Resort: Codable, Hashable, Identifiable {
    var id: String
    var name: String
    var country: String
    var description: String
    var imageCredit: String
    var price: Int
    var size: Int
    var snowDepth: Int
    var elevation: Int
    var runs: Int
    private var facilities: [String]
    var facilityTypes: [Facility] {
        facilities.map(Facility.init)
    }
}

extension Resort {
    static let allResorts: [Resort] = Bundle.main.decode("resorts.json")
    static let example = allResorts[0]
}

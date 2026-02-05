//
//  ExpenseItem.swift
//  iExpense
//
//  Created by niccho on 4/11/2025.
//

import SwiftData
import SwiftUI

@Model
class ExpenseItem: Identifiable, Codable, Equatable {
    enum CodingKeys: CodingKey {
        case id, name, type, amount
    }

    var id: UUID
    var name: String
    var type: String
    var amount: Double

    init(name: String, type: String, amount: Double) {
        id = UUID()
        self.name = name
        self.type = type
        self.amount = amount
    }

    required init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(UUID.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        type = try container.decode(String.self, forKey: .type)
        amount = try container.decode(Double.self, forKey: .amount)
    }

    func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(type, forKey: .type)
        try container.encode(amount, forKey: .amount)
    }
}

//
//  Order.swift
//  CupcakeCorner
//
//  Created by niccho on 10/11/2025.
//

import SwiftUI

struct Address: Codable {
    var name = ""
    var street = ""
    var city = ""
    var zip = ""
}

@Observable
class Order: Codable {
    enum CodingKeys: String, CodingKey {
        case _type = "type"
        case _quantity = "quantity"
        case _specialRequestEnabled = "specialRequestEnabled"
        case _extraFrosting = "extraFrosting"
        case _addSprinkles = "addSprinkles"
        case _address = "address"
    }
    
    static let types = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]
    var type = 0
    var quantity = 3
    var specialRequestEnabled = false {
        didSet {
            if specialRequestEnabled == false {
                extraFrosting = false
                addSprinkles = false
            }
        }
    }
    var extraFrosting = false
    var addSprinkles = false
    
    var address = Address() {
        didSet {
            if let encoded = try? JSONEncoder().encode(address) {
                print("Saving address")
                UserDefaults.standard.set(encoded, forKey: "orderAddress")
            }
        }
    }
    
    init() {
        if let address = UserDefaults.standard.data(forKey: "orderAddress") {
            if let decoded = try? JSONDecoder().decode(Address.self, from: address) {
                self.address = decoded
                return
            }
        }
    }

    var hasValidAddress: Bool {
        if address.name
            .trimmingCharacters(in: .whitespaces).isEmpty ||
            address.street.trimmingCharacters(in: .whitespaces).isEmpty ||
            address.city.trimmingCharacters(in: .whitespaces).isEmpty ||
            address.zip.trimmingCharacters(in: .whitespaces).isEmpty
        {
            return false
        }

        return true
    }

    var cost: Decimal {
        var cost = Decimal(quantity) * 2

        cost += Decimal(type) / 2

        if extraFrosting {
            cost += Decimal(quantity)
        }

        if addSprinkles {
            cost += Decimal(quantity) / 2
        }

        return cost
    }
}

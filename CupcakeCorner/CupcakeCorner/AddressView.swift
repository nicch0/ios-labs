//
//  AddressView.swift
//  CupcakeCorner
//
//  Created by niccho on 10/11/2025.
//

import SwiftUI

struct AddressView: View {
    @Bindable var order: Order

    var body: some View {
        Form {
            Section {
                TextField("Name", text: $order.address.name)
                TextField("Street Address", text: $order.address.street)
                TextField("City", text: $order.address.city)
                TextField("Zip", text: $order.address.zip)
            }
            
            Section {
                NavigationLink("Checkout") {
                    CheckoutView(order: order)
                }
            }
            .disabled(order.hasValidAddress == false)
        }
        .navigationTitle("Delivery details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    AddressView(order: Order())
}

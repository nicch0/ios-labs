//
//  AddressView.swift
//  CupcakeCorner
//
//  Created by niccho on 10/11/2025.
//

import SwiftUI

struct CheckoutView: View {
    var order: Order
    @State private var confirmationMessage = ""
    @State private var showingConfirmation = false
    
    @State private var showingFailureAlert = false
    @State private var failureMessage = ""

    var body: some View {
        ScrollView {
            VStack {
                AsyncImage(url: URL(string: "https://hws.dev/img/cupcakes@3x.jpg"), scale: 3) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    ProgressView()
                }
                .frame(height: 233)

                Text("Final cost: \(order.cost, format: .currency(code: "USD"))")
                    .font(.title)

                Button("Place Order") {
                    Task {
                        await placeOrder()
                    }
                }
                .padding()
            }
        }
        .alert("Failed to place order", isPresented: $showingFailureAlert) {
            Button("OK") {}
        } message: {
            if !failureMessage.isEmpty {
                Text(failureMessage)
            }
        }
        .navigationTitle("Checkout")
        .navigationBarTitleDisplayMode(.inline)
        .scrollBounceBehavior(.basedOnSize)
        .alert("Thank you!", isPresented: $showingConfirmation) {
            Button("OK") { }
        } message: {
            Text(confirmationMessage)
        }
    }

    func placeOrder() async {
        guard let encoded = try? JSONEncoder().encode(order) else {
            print("Order could not be encoded")
            return
        }

        let url = URL(string: "https://reqres.in/api/cupcakes")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("reqres-free-v1", forHTTPHeaderField: "x-api-key") //the line to add
        request.httpMethod = "POST"
        
        do {
            let (data, _) = try await URLSession.shared.upload(for: request, from: encoded)
        
            let decodedOrder = try JSONDecoder().decode(Order.self, from: data)
            confirmationMessage = "Your order for \(decodedOrder.quantity)x \(Order.types[decodedOrder.type].lowercased()) cupcakes is on its way!"
            showingConfirmation = true
        } catch {
            failureMessage = error.localizedDescription
            showingFailureAlert = true
        }
        
    }
}

#Preview {
    CheckoutView(order: Order())
}

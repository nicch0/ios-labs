//  Our address fields are currently considered valid if they contain anything, even if it’s just only whitespace. Improve the validation to make sure a string of pure whitespace is invalid.
//    If our call to placeOrder() fails – for example if there is no internet connection – show an informative alert for the user. To test this, try commenting out the request.httpMethod = "POST" line in your code, which should force the request to fail.
//    For a more challenging task, try updating the Order class so it saves data such as the user's delivery address to UserDefaults. This takes a little thinking, because @AppStorage won't work here, and you'll find getters and setters cause problems with Codable support. Can you find a middle ground?


import SwiftUI

struct ContentView: View {
    @State private var order = Order()
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    Picker("Cake type", selection: $order.type){
                        ForEach(Order.types.indices, id: \.self) { idx in
                            Text(Order.types[idx])
                        }
                    }.pickerStyle(.segmented)
                    
                    Stepper(
                        "Quantity: \(order.quantity)",
                        value: $order.quantity,
                        in: 3...20
                    )
                }
                
                Section {
                    Toggle("Any special requests?", isOn: $order.specialRequestEnabled)
                    
                    if order.specialRequestEnabled {
                        Toggle("Extra Frosting", isOn: $order.extraFrosting)
                        Toggle("Add Sprinkles", isOn: $order.addSprinkles)
                    }
                }
                
                NavigationLink("Delivery details") {
                    AddressView(order: order)
                }
            }
            .navigationTitle("Cupcake Corner")
        }
        
    }
}

#Preview {
    ContentView()
}

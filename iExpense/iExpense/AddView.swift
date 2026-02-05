//
//  AddView.swift
//  iExpense
//
//  Created by niccho on 4/11/2025.
//

import SwiftData
import SwiftUI

struct AddView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss

    @State private var name = ""
    @State private var type = "Personal"
    @State private var amount = 0.0
    
    var isFormValid: Bool {
        !name.isEmpty && amount > 0.0
    }

    var body: some View {
        NavigationStack {
            Form {
                Picker("Type", selection: $type) {
                    Text("Personal use").tag("Personal")
                    Text("Business use").tag("Business")
                }

                TextField(
                    "Amount",
                    value: $amount,
                    format: .currency(code: Locale.current.currency?.identifier ?? "AUD")
                )
                .keyboardType(.decimalPad)
            }
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                    }
                }

                ToolbarItem(placement: .principal) {
                    TextField("Name", text: $name)
                        .font(.headline)
                }

                ToolbarItem(placement: .confirmationAction) {
                    Button {
                        let item = ExpenseItem(name: name, type: type, amount: amount)
                        modelContext.insert(item)
                        print("added expense \(item.name)")
                        dismiss()
                    } label: {
                        Image(systemName: "checkmark")
                    }
                    .buttonStyle(.glassProminent)
                }
            }
        }
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: ExpenseItem.self, configurations: config)
        return AddView().modelContainer(container)
    } catch {
        return Text("Failed to create preview")
    }
}

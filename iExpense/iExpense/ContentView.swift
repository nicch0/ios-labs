//
//  ContentView.swift
//  iExpense
//
//  Created by niccho on 4/11/2025.
//

import SwiftData
import SwiftUI

extension Text {
    func expenseStyling(amount: Double) -> some View {
        var foregroundStyle: Color {
            switch amount {
            case 100...: return .yellow
            case 10 ..< 100: return .gray
            default: return .brown
            }
        }

        return self
            .foregroundStyle(foregroundStyle)
    }
}

enum FilterType: String {
    case all, personalOnly, businessOnly
}

struct ExpenseListView: View {
    @Environment(
        \.modelContext
    ) var modelContext
    @Query var expenses: [ExpenseItem]

    init(filter: FilterType, sortOrder: [SortDescriptor<ExpenseItem>]) {
        var predicate: Predicate<ExpenseItem>?
        switch filter {
        case .all:
            predicate = nil
        case .personalOnly:
            predicate = #Predicate { $0.type == "Personal" }
        case .businessOnly:
            predicate = #Predicate { $0.type == "Business" }
        }

        if let predicate {
            _expenses = Query(filter: predicate, sort: sortOrder)
        } else {
            _expenses = Query(sort: sortOrder)
        }
    }

    func removeExpenses(_ indexSet: IndexSet) {
        for idx in indexSet {
            let expense = expenses[idx]
            modelContext.delete(expense)
        }
    }

    var body: some View {
        List {
            ForEach(expenses) { item in
                HStack {
                    ExpenseItemView(item: item)
                }
            }
            .onDelete { removeExpenses($0) }
        }
        .listStyle(.insetGrouped)
    }
}

struct ContentView: View {
    @State private var sortOrder: [SortDescriptor<ExpenseItem>] = [
        SortDescriptor(\ExpenseItem.name),
        SortDescriptor(\ExpenseItem.amount, order: .reverse),
    ]

    @State private var filter: FilterType = .all

    @State private var showAddExpense = false

    var body: some View {
        NavigationStack {
            ExpenseListView(filter: filter, sortOrder: sortOrder)
                .headerProminence(.increased)
                .toolbar {
                    ToolbarItemGroup(placement: .topBarTrailing) {
                        Menu("Filter", systemImage: "line.3.horizontal.decrease") {
                            Picker("Filter", selection: $filter) {
                                Text("All").tag(FilterType.all)
                                Text("Personal Expenses").tag(FilterType.personalOnly)
                                Text("Business Expenses").tag(FilterType.businessOnly)
                            }
                        }

                        Menu("Sort", systemImage: "arrow.up.arrow.down") {
                            Picker("Sort", selection: $sortOrder) {
                                Text("By Name").tag([
                                    SortDescriptor(\ExpenseItem.name),
                                    SortDescriptor(\ExpenseItem.amount, order: .reverse),
                                ])
                                Text("By Amount (descending)").tag([
                                    SortDescriptor(\ExpenseItem.amount, order: .reverse),
                                    SortDescriptor(\ExpenseItem.name),
                                ])
                            }
                        }

                        NavigationLink {
                            AddView()
                                .navigationBarBackButtonHidden()
                        } label: {
                            Label("New Expense", systemImage: "plus")
                        }
                    }
                }
                .navigationTitle("iExpense")
        }
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: ExpenseItem.self, configurations: config)

        let expenseItems = [
            ExpenseItem(name: "Coffee", type: "Personal", amount: 5.0),
            ExpenseItem(name: "Banana", type: "Personal", amount: 6.0),
            ExpenseItem(name: "Toaster", type: "Personal", amount: 20.0),
            ExpenseItem(name: "Car", type: "Personal", amount: 2000.0),

            ExpenseItem(name: "Hookers", type: "Business", amount: 50000.0),
        ]

        for expenseItem in expenseItems {
            container.mainContext.insert(expenseItem)
        }

        return ContentView().modelContainer(container)

    } catch {
        return Text("Failed to create preview")
    }
}

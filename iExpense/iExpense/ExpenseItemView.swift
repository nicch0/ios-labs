//
//  ExpenseItemView.swift
//  iExpense
//
//  Created by niccho on 14/11/2025.
//

import SwiftUI

struct ExpenseItemView: View {
    var item: ExpenseItem
    var body: some View {
        VStack(alignment: .leading) {
            Text(item.name)
                .font(.headline)
            Text(item.type)
        }
        Spacer()
        Text(
            item.amount,
            format: .currency(code: Locale.current.currency?.identifier ?? "AUD")
        )
        .expenseStyling(amount: item.amount)
    }
}

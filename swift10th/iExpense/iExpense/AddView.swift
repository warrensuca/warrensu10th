//
//  AddView.swift
//  iExpense
//
//  Created by warren su on 7/3/25.
//

import SwiftUI




struct AddView: View {
    @Environment(\.dismiss) var dismiss
    @State private var name = ""
    @State private var type = "Personal"
    @State private var amount = 0.0
    
    
    var expenses: Expenses
    let types = ["Business", "Personal"]
    var body: some View {
        NavigationStack {
            Form {
                TextField("Name", text: $name)
                
                Picker("Type", selection: $type) {
                    ForEach(types, id: \.self) {
                        Text($0)
                    }
                }
                
                TextField("Amount", value: $amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                    .keyboardType(.decimalPad)
                
                
            }
            .toolbar {
                Button("Save") {
                    expenses.items.append(ExpenseItem(name: name, type: type, amount: amount))
                    
                    dismiss()
                }
                
            }.navigationTitle("Add New Expense")
            
            
            
        }
    }
}

#Preview {
    AddView(expenses: Expenses())
}

//
//  AddView.swift
//  iExpense
//
//  Created by warren su on 7/3/25.
//
import SwiftData
import SwiftUI




struct AddView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    @State private var name = "Expense Name"
    @State private var type = "Personal"
    @State private var amount = 0.0
    
    

    
    let types = ["Business", "Personal"]
    var body: some View {
        NavigationStack {
            Form {

                
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
                    let item = ExpenseItem(name: name, type: type, amount: amount)
                    modelContext.insert(item)
                    //try? modelContext.save()
                    print("Saving item: \(item.name), \(item.type), \(item.amount)")
                    dismiss()
                }
                
            }.navigationTitle($name)
                .navigationBarTitleDisplayMode(.inline)
            
            
            
        }
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: ExpenseItem.self, configurations: config)
    
    return AddView()
        .modelContainer(container)
}

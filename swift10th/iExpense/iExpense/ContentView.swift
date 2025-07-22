//
//  ContentView.swift
//  iExpense
//
//  Created by warren su on 6/28/25.
//
import SwiftData
import SwiftUI

@Observable
class User {
    var firstName = "Biblo"
    var lastName = "Baggins"
}

@Model
class ExpenseItem: Identifiable{
    var id = UUID()
    var name: String
    var type: String
    var amount: Double
    
    init(id: UUID = UUID(), name: String, type: String, amount: Double) {
        self.id = id
        self.name = name
        self.type = type
        self.amount = amount
    }
    
}
struct DebugView: View {
    @Query var allExpenses: [ExpenseItem]
    
    var body: some View {
        VStack {
            Text("Total expenses: \(allExpenses.count)")
            
            ForEach(allExpenses) { expense in
                Text("\(expense.name) - \(expense.type) - \(expense.amount)")
            }
        }
    }
}

struct ContentView: View {
    
    
    @Environment(\.modelContext) var modelContext
    @State private var sortOrder = [SortDescriptor(\ExpenseItem.amount)]
    @State private var currentDisplayType = "All"
    
    @Query var expenses: [ExpenseItem]
        
    
    @State private var showingSheet = false
    
    
    var body: some View {
        NavigationStack {
            
            //DebugView()
            DisplayView(sortOrder: sortOrder, currentDisplayType: currentDisplayType)
                .navigationTitle("iExpense")
                .toolbar {
                    
                    
                    Menu("Filter") {
                        Picker("Filter", selection: $currentDisplayType) {
                            Text("Business")
                                .tag("Business")
                            
                            Text("Personal")
                                .tag("Personal")
                            
                            Text("All")
                                .tag("All")
                        }
                    }
                    
                    Menu("Sort", systemImage: "arrow.up.arrow.down") {
                        Picker("Sort", selection: $sortOrder) {
                            Text("Sort by Name")
                                .tag([SortDescriptor(\ExpenseItem.name)])
                            
                            Text("Sort by Price")
                                .tag([SortDescriptor(\ExpenseItem.amount, order: .reverse)])
                        }
                    }
                    Button("Add expense", systemImage: "plus") {
                        showingSheet = true
                    }
                    
                }
            
                .sheet(isPresented: $showingSheet) {
                    AddView()
                }

                
        }
    }
}




#Preview {
    ContentView()
}

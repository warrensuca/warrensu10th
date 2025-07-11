//
//  ContentView.swift
//  iExpense
//
//  Created by warren su on 6/28/25.
//

import SwiftUI

@Observable
class User {
    var firstName = "Biblo"
    var lastName = "Baggins"
}

struct ExpenseItem:Identifiable, Codable {
    let id = UUID()
    let name: String
    let type: String
    let amount: Double
    
}
@Observable
class Expenses {
    init() {
        if let savedItems = UserDefaults.standard.data(forKey: "Items"){
            if let decodedItems = try? JSONDecoder().decode([ExpenseItem].self, from: savedItems) {
                items = decodedItems
                return
            }
        }
    }
    
    var items = [ExpenseItem](){
        didSet{
            if let encoded = try? JSONEncoder().encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }
}

struct ContentView: View {
    @State private var expenses = Expenses()

    
    @State private var showingSheet = false
    
    
    var body: some View {
        NavigationStack {
            HStack {
                NavigationLink("Add Expense") {
                    AddView(expenses: expenses)
                }
                .padding()
            }
            
                

            Text("Personal Expenses").font(.headline)
            List {
                ForEach(expenses.items.filter {$0.type == "Personal"}) { item in
                    HStack{
                        VStack(alignment: .leading){
                            Text(item.name)
                                .font(.headline)
                            
                            Text(item.type)
                        }
                        Spacer()
                        if item.amount > 100 {
                            Text(item.amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD")).BigBallerStyle()
                        }
                        else if item.amount > 10 {
                            Text(item.amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                                .font(.headline)
                        }
                        else {
                            Text(item.amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD")).font(.caption)
                        }
                    }
                }.onDelete(perform: removeitems)
            }
            

            Text("Business Expenses")
                .font(.headline)
        
            List {
                ForEach(expenses.items.filter {$0.type == "Business"}) { item in
                    HStack{
                        VStack(alignment: .leading){
                            Text(item.name)
                                .font(.headline)
                            
                            Text(item.type)
                        }
                        Spacer()
                        if item.amount > 100 {
                            Text(item.amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD")).BigBallerStyle()
                        }
                        else if item.amount > 10 {
                            Text(item.amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                                .font(.headline)
                        }
                        else {
                            Text(item.amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD")).font(.caption)
                        }
                    }
                }.onDelete(perform: removeitems)
            }
            

            
            
            .navigationTitle("iExpense")
            .toolbar {
                Button("Add expense", systemImage: "plus") {
                    showingSheet = true
                }
            }
            .sheet(isPresented: $showingSheet) {
                AddView(expenses: expenses)
            }
        }
        }
    
    func removeitems(offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }

    
}


struct BigBallerFont: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .font(.title)
            .fontWeight(.bold)
            .foregroundStyle(.yellow)
    }
}

extension View {
    func BigBallerStyle() -> some View {
        modifier(BigBallerFont())
    }
}

#Preview {
    ContentView()
}

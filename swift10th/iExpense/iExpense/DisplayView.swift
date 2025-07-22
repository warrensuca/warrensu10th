//
//  DisplayView.swift
//  iExpense
//
//  Created by warren su on 7/21/25.
//
import SwiftData
import SwiftUI

struct DisplayView: View {
    @Environment(\.modelContext) var modelContext
    
    
    @Query var expenses: [ExpenseItem]
    var currentDisplayType: String
    var sortOrder: SortDescriptor<ExpenseItem>
    
    
    init(sortOrder: SortDescriptor<ExpenseItem>, currentDisplayType: String) {
        _expenses = Query(filter: #Predicate<ExpenseItem> {item in item.type == currentDisplayType || currentDisplayType == "All"}, sort: [sortOrder])
        self.currentDisplayType = currentDisplayType
        self.sortOrder = sortOrder
    }
    
    
    var body: some View {
        VStack{
            HStack {
                NavigationLink("Add Expense") {
                    AddView()
                }
                .padding()
            }
            
            
            Text("\(currentDisplayType) Expenses").font(.headline)
            List {
                ForEach(expenses) { item in
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
                    .onAppear {
                        do {
                            let items = try modelContext.fetch(FetchDescriptor<ExpenseItem>())
                            print("Fetched items count: \(items.count)")
                            for item in items {
                                print("\(item.name) - \(item.type) - \(item.amount)")
                            }
                        } catch {
                            print("Error fetching: \(error.localizedDescription)")
                        }
                    }
            }
        }
        
    }
    func removeitems(offsets: IndexSet) {
        for offset in offsets {
            let expense = expenses[offset]
            modelContext.delete(expense)
        }
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
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: ExpenseItem.self, configurations: config)

    // Sample items
    let context = container.mainContext
    let sampleItems = [
        ExpenseItem(name: "Lunch", type: "Business", amount: 12.0),
        ExpenseItem(name: "Coffee", type: "Personal", amount: 4.5),
        ExpenseItem(name: "Desk", type: "Business", amount: 200.0)
    ]
    sampleItems.forEach { context.insert($0) }

    return DisplayView(
        sortOrder: SortDescriptor(\ExpenseItem.amount),
        currentDisplayType: "All"
    )
    .modelContainer(container)
}

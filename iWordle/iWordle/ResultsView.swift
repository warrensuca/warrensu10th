//
//  ResultsView.swift
//  iWordle
//
//  Created by warren su on 8/12/25.
//
import SwiftData
import SwiftUI
import Foundation
struct ResultsView: View {
    
    @Environment(\.modelContext) private var modelContext
    @State var sortOrder: [SortDescriptor<SolveRun>]
    
    @State var deletingHistory = false
    var body: some View {
        NavigationStack{

                ResultsListView(sortOrder: sortOrder)
                    .alert("Are you sure?", isPresented: $deletingHistory) {
                        Button("Yes") {deleteAllData()}
                    } message: {Text("If you delete your history of solves, it is impossible to recover")}
                

                .toolbar {
                    ToolbarItem{
                        Menu("Sort", systemImage: "arrow.up.arrow.down") {
                            Picker("Sort Order", selection: $sortOrder) {
                                
                                Text("Efficiency")
                                    .tag([SortDescriptor(\SolveRun.attempts), SortDescriptor(\SolveRun.date)])
                                Text("Oldest")
                                    .tag([SortDescriptor(\SolveRun.date)])
                                Text("Most Recent")
                                    .tag([SortDescriptor(\SolveRun.date, order: .reverse)])
                            }
                            
                        }
                    }
                    ToolbarItem{
                        Button {
                            deletingHistory = true
                        } label: {
                            Image(systemName: "trash")
                                .foregroundStyle(.red)
                        }
                    }
            }
        }
    }
    
    func deleteAllData() {
        do {
            try modelContext.delete(model: SolveRun.self)


        } catch {
            print("Failed to delete all data: \(error.localizedDescription)")
        }
    }
    
}

#Preview {
    
}

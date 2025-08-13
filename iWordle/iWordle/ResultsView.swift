//
//  ResultsView.swift
//  iWordle
//
//  Created by warren su on 8/12/25.
//
import SwiftData
import SwiftUI

struct ResultsView: View {
    @Query var results: [SolveRun]
    
    @State var sortOrder: [SortDescriptor<SolveRun>]
    let emojiRating = [7: "❌"]
    
    var body: some View {
        NavigationStack{
            List {
                ForEach(results, id: \.self) {result in
                    NavigationLink {
                        WordleDisplay(wordDisplays: result.wordDisplays, sizeMultiplier: 3)
                    } label: {
                        HStack{
                            Text(result.date.formatted(date: .complete, time: .omitted))
                            Text("Solved in: \(result.attempts)")
                        }
                    }
                }
            }
                .toolbar {
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
        }
    }
    
    
    init(sortOrder: [SortDescriptor<SolveRun>]){
        self.sortOrder = sortOrder
        _results = Query(sort: sortOrder)
    }
}

#Preview {
    
}

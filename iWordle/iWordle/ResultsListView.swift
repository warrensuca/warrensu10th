//
//  ResultsListView.swift
//  iWordle
//
//  Created by warren su on 8/12/25.
//
import SwiftData
import SwiftUI

struct ResultsListView: View {
    @Query var results: [SolveRun]
    let emojiRating = [7:"❌", 6: "😬", 5: "🤷‍♂️", 4: "👍", 3: "🤩", 2: "🤯", 1: "🥳"]
    
    private let dateFormatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateFormat = "MM/dd/yy"
            return formatter
        }()
    
    var sortOrder: [SortDescriptor<SolveRun>]
    var body: some View {
        List {
            ForEach(results, id: \.self) {result in
                NavigationLink {
                    WordleDisplay(wordDisplays: result.wordDisplays, sizeMultiplier: 3.0)
                } label: {
                    HStack{
                        
                        Text(dateFormatter.string(from: result.date))
                        Text(result.attempts < 7 ? "Solved in: \(result.attempts)" : "Not solved")
                        Text(emojiRating[min(result.attempts,7)] ?? " " )
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
    ResultsListView(sortOrder: [SortDescriptor(\SolveRun.date)])
}

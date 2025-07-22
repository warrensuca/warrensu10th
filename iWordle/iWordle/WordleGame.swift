//
//  WordleGame.swift
//  iWordle
//
//  Created by warren su on 7/21/25.
//

import SwiftUI

struct WordleGame: View {
    var allWords: [String]
    @State private var currRow = 0
    var body: some View {
        NavigationStack{
            VStack{
                ForEach(0..<6) { i in 
                    WordView(row: i, currRow: $currRow, targetWord: "Hello")
                        .padding(5)
                }
            }
        }
    }
}

#Preview {
    WordleGame(allWords: getWords())
}

//
//  ContentView.swift
//  iWordle
//
//  Created by warren su on 7/21/25.
//

import SwiftUI

struct ContentView: View {
    var allWords = getWords()
    var body: some View {
        NavigationStack{
            Form{
                NavigationLink("Game") {
                    WordleGame(allWords: allWords)
                }
                NavigationLink("Solve") {
                    WordleSolve(allWords: allWords)
                }
            }
        }
    }
}

func getWords() -> [String]{
    if let fileURL = Bundle.main.url(forResource: "valid-wordle-words", withExtension: "txt"){
        if let wordleWords = try? String(contentsOf: fileURL, encoding: .utf8) {
            let allWords = wordleWords.components(separatedBy: "\n")
            
            return allWords
        }
    }
    fatalError("Could not load the words from bundle.")
}
#Preview {
    ContentView()
}

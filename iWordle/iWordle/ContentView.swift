//
//  ContentView.swift
//  iWordle
//
//  Created by warren su on 7/21/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack{
            NavigationLink("Game") {
                WordleGame(allWords: getWords())
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

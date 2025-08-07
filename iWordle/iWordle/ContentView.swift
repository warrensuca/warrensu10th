//
//  ContentView.swift
//  iWordle
//
//  Created by warren su on 7/21/25.
//

import SwiftUI

struct ContentView: View {
    var allWords = getWords()
    var allAnswerWords = getAnswerWords()
    var body: some View {
        NavigationStack{
            Form{
                NavigationLink("Game") {
                    WordleGame(allWords: allWords, allAnswerWords: allAnswerWords)
                }
                NavigationLink("Solve") {
                    WordleSolve(allWords: allWords, allAnswerWords: allAnswerWords)
                }
            }
        }
    }
}

func getWords() -> [String]{
    if let fileURL = Bundle.main.url(forResource: "valid-wordle-words", withExtension: "txt"){
        if let wordleWords = try? String(contentsOf: fileURL, encoding: .utf8) {
            let allWords = wordleWords.components(separatedBy: "\n")
            print(allWords.count)
            return allWords
        }
    }
    fatalError("Could not load the words from bundle.")
}

func getAnswerWords() -> [String] {
    if let fileURL = Bundle.main.url(forResource: "wordle-answers", withExtension: "txt"){
        if let wordleWords = try? String(contentsOf: fileURL, encoding: .utf8) {
            let allAnswerWords = wordleWords.components(separatedBy: "\n")
            print(allAnswerWords.count)
            return allAnswerWords
        }
    }
    fatalError("Could not load the words from bundle.")
}
#Preview {
    ContentView()
}

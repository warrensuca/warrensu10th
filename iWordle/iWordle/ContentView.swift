//
//  ContentView.swift
//  iWordle
//
//  Created by warren su on 7/21/25.
//
import SwiftData
import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    var allWords = getWords()
    var allAnswerWords = getAnswerWords()
    @Query var SolveRuns: [SolveRun]
    var body: some View {
        NavigationStack{
            VStack{
                NavigationLink() {
                    WordleGame(allWords: allWords, allAnswerWords: allAnswerWords)
                } label: {
                    VStack {
                        Image(.wordleGameCover)
                            .resizable()
                            .scaledToFit()
                        Text("Game")
                            .font(.headline)
                            .scaledToFit()
                    }
                    .padding()
                    .border(.black)
                    .overlay(
                        RoundedRectangle(cornerRadius:10)
                            .stroke(.black)
                        )
                    .frame(height:200)
                }
                
                Rectangle()
                    .frame(height: 2)
                    
                    .padding(.vertical)
                
                NavigationLink() {
                    WordleSolve(allWords: allWords, allAnswerWords: allAnswerWords)
                } label: {
                    VStack {
                        Image(.wordleSolvedImage1)
                            .resizable()
                            .scaledToFit()
                        
                        Text("Solve")
                            .font(.headline)
                            .scaledToFit()
                    }
                }.clipShape(.rect(cornerRadius: 10))
                    .padding()
                    .frame(height:225)
                
                    .frame(maxWidth: .infinity)
                NavigationLink() {
                    ResultsView(sortOrder: [SortDescriptor(\SolveRun.date, order: .reverse)])
                } label: {
                    VStack {
                        Image(.wordleSolvedImage1)
                            .resizable()
                            .scaledToFit()
                        
                        Text("Solve")
                            .font(.headline)
                            .scaledToFit()
                    }
                }.clipShape(.rect(cornerRadius: 10))
                    .padding()
                    .frame(height:225)
                
                    .frame(maxWidth: .infinity)
                
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

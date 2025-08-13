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
                    }.background(.gray)
                    
                    
                }.padding()
                    .border(.black)
                    .clipShape(.rect(cornerRadius: 10))
                    
            
                    .frame(height:180)
                    .frame(maxWidth: .infinity)
                
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
                    }.background(.gray)
                }.clipShape(.rect(cornerRadius: 10))
                    .padding()
                    .frame(height:205)
                
                    .frame(maxWidth: .infinity)
                
                
                
                Rectangle()
                    .frame(height: 2)
                    
                    .padding(.vertical)
                NavigationLink() {
                    ResultsView(sortOrder: [SortDescriptor(\SolveRun.date, order: .reverse)])
                } label: {
                    VStack {
                        Image(.wordleSolvedImage1)
                            .resizable()
                            .scaledToFit()
                        
                        Text("Past Runs")
                            .font(.headline)
                            .scaledToFit()
                    }
                    .background(.gray)
                }.clipShape(.rect(cornerRadius: 10))
                    .padding()
                    .frame(height:205)
                
                    .frame(maxWidth: .infinity)
                
            }
            .navigationTitle("iWordle")
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

//
//  ContentView.swift
//  Word Scramble
//
//  Created by warren su on 6/22/25.
//

import SwiftUI

struct ContentView: View {
    @State private var usedWords = [String]()
    @State private var rootWord = ""
    @State private var newWord = ""
    
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showingError = false
    
    @State private var score = 0.0
    var body: some View {
        NavigationStack{
            List {
                Section(){
                    TextField("Enter your word", text: $newWord)
                        .textInputAutocapitalization(.never)
                        .onSubmit {
                            
                            addNewWord()
                        }
                }
                Section {
                    ForEach(usedWords, id: \.self) {
                        word in Text(word)
                    }
                }
            }.navigationTitle(rootWord)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("New Word") {
                        startGame()
                    }
                }
                
                ToolbarItem(placement: .topBarLeading) {
                    Text("Score: \(Int(score))")
                }
            }
            .onAppear(perform: startGame)
            
            .alert(errorTitle, isPresented: $showingError) {} message: {
                Text(errorMessage)
            }
        }
        

    }
    func addNewWord() {

        if !isInvalidWord() {
            let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
            
            if answer.count <= 0 {
                return
            }
            withAnimation{
                usedWords.insert(answer, at: 0)
                score += calculateScore()
            }
            
            newWord = ""
            
        }
        else {
            errorTitle = "Error!"
            errorMessage = "Make sure to use a word that is valid, use the characters given, and not repeat previous answers"
            showingError = true
        }
    }
    func startGame() {
        score = 0
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            if let startWords = try? String(contentsOf: startWordsURL, encoding: .utf8) {
                let allWords = startWords.components(separatedBy: "\n")
                rootWord = allWords.randomElement() ?? "silkworm"
                print(rootWord)
                return
            }
        }

        fatalError("Could not load start.txt from bundle.")
    }
    
    func isInvalidWord() -> Bool{
        
        
        
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        print(answer)
        var tempRoot = rootWord
        for char in newWord {

            if let i = tempRoot.firstIndex(of: char) {
                tempRoot.remove(at: i)

            }
            else {
                return true
            }
        }
        
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: answer.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: answer, range: range, startingAt: 0, wrap: false, language: "en")
        print(usedWords.contains(newWord))
        print(misspelledRange.location != NSNotFound)
        
        return misspelledRange.location != NSNotFound || usedWords.contains(answer) || answer.count < 3 || rootWord == answer
        
    }
    
    func calculateScore() -> Double {
        //*1.2 as a power up/streak kind of thing, he said to involve the # of words
        
        return 5 * (Double(newWord.count)/Double(rootWord.count)) * 1.2
    }

}

#Preview {
    ContentView()
}


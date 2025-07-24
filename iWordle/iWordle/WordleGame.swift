//
//  WordleGame.swift
//  iWordle
//
//  Created by warren su on 7/21/25.
//

import SwiftUI

struct WordleGame: View {
    var allWords: [String]
    @State var targetWord = "Hello"
    @State private var currRow = 0
    @State private var currCount = 0
    @State private var gameEnd = false
    var body: some View {
        NavigationStack{
            VStack{
                ForEach(0..<6) { i in
                    WordView(row: i, gameEnd: $gameEnd, currRow: $currRow, currCount: $currCount, targetWord: targetWord)
                        .padding(5)
                    }
                }
            .onAppear(){
                startGame()
            }
            .alert(currCount == 5 ? "You have won!" : "You have lost...", isPresented: $gameEnd) {
                    Button("Ok") {}
            } message: {Text("The word was \(targetWord)")}

            }
        
        }
    
    func startGame() {
        targetWord = allWords.randomElement() ?? "hello"
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: targetWord.utf16.count)
        var misspelledRange = checker.rangeOfMisspelledWord(in: targetWord, range: range, startingAt: 0, wrap: false, language: "en")
        while misspelledRange.location != NSNotFound {
            misspelledRange = checker.rangeOfMisspelledWord(in: targetWord, range: range, startingAt: 0, wrap: false, language: "en")
            targetWord = allWords.randomElement() ?? "hello"
        }
        targetWord = targetWord.uppercased()
        print(targetWord)
        
    }
}


#Preview {
    WordleGame(allWords: getWords(), targetWord: "Hello")
}

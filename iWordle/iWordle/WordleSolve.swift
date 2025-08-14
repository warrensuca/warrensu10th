//
//  WordleSolve.swift
//  iWordle
//
//  Created by warren su on 7/22/25.
//

import SwiftUI

struct ButtonTileView: View {
    var letter: Character
    var colors = [Color.white,Color.yellow,Color.green]
    @Binding var colorIndex: Int

    
    var body: some View{
        Button {
            colorIndex = (colorIndex+1)%3
        } label: {
            ZStack{
                
                
                Rectangle()
                    .frame(width: 65, height:65)
                    .foregroundStyle(.gray)

                Rectangle()
                    .frame(width: 60, height:60)
                    .foregroundStyle(colors[colorIndex])

                Text("\(letter)")
                    .font(.system(size: 60))
                    .foregroundStyle(.black)
                
            }
            
        }
    }
}
extension String {
    func getLetter(i: Int) -> Character {
        if i >= self.count {
            return " "
        } else {
            let index = self.index(self.startIndex, offsetBy: i)
            return self[index]
        }
    }
}



struct WordleSolve: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    
    @State private var colorIndexes = [0,0,0,0,0]
    @State private var submittedWord = ""
    @FocusState private var focused: Bool
    @State private var wrongSpelling = false
    @State private var answers = [String]()
    @State private var wordDisplays = [[String: [Int]]]()
    
    @State var allWords: [String]
    var allAnswerWords: [String]
    @State var unusedVowels = ["a", "e", "i", "o", "u"]
    @State var solved = false
    @State var askForSolvedWord = false
    @State var solvedWord = ""
    
    var body: some View {
        NavigationStack{
            VStack(alignment: .center){
                HStack{
                    ForEach(0..<5, id: \.self) { i in
                        
                        ButtonTileView(letter:  submittedWord.getLetter(i: i), colorIndex: $colorIndexes[i])
                        
                    }
                    
                }
                TextField("enter word", text: $submittedWord).focused($focused, equals: true)
                
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.75) {
                            self.focused = true
                        }
                    }
                    .onChange(of: submittedWord) {
                        submittedWord = submittedWord.uppercased()
                    }
                    .autocorrectionDisabled()
                    .frame(width:0,height:0)
                    .onSubmit {
                        
                        wrongSpelling = Set(allWords).contains(submittedWord.lowercased()) == false
                        self.focused = true
                        
                        if wrongSpelling == false  {
                            wordDisplays.append([submittedWord: colorIndexes])}
                        answers = findWords()
                        print(answers)
                    }
                VStack(alignment: .leading){
                    WordleDisplay(wordDisplays: wordDisplays)
                    }
                
                NavigationLink("See Options") {
                    OptionsView(words: answers, answerWords: allAnswerWords)
                }.buttonStyle(.borderedProminent)
                    .padding()

                
                HStack {
                    Text("Solved?")
                    
                    Button("✅") {
                        solved = true
                        askForSolvedWord = true
                    }
                    Button("❌") {
                        solved = false
                    }
                }.alert("What was the word?!", isPresented: $askForSolvedWord) {
                    
                    TextField("Enter Word", text: $solvedWord)
                }
                .padding()
                
                .toolbar {
                    
                    
                    Button("Save & Dismiss") {
                        saveRun()
                    }
                    
                    
                    
                    
                }
                
                
                
            }
            
            
            
            .alert("Invalid word", isPresented: $wrongSpelling) {
                Button("Ok") { }
            } message: {
                Text("This word is not a possibility")
            }
            
        }
        
    }
    
    
    
    
    func saveRun() {
        
        if let match = wordDisplays.first(where: { $0.values.contains([2,2,2,2,2]) }) {
            solvedWord = match.keys.first ?? ""
            
        }
        
        if askForSolvedWord {
            wordDisplays.append([solvedWord: [2,2,2,2,2]])
        }
        print(solvedWord)
        solved = solved || solvedWord != ""
        let newRun = SolveRun(attempts: solved ? wordDisplays.count : 7, wordDisplays: wordDisplays)
        
        modelContext.insert(newRun)
        try? modelContext.save() 
        dismiss()
    }
    
    func findWords() -> [String] {
        submittedWord = submittedWord.lowercased()
        print("hello")
        var foundWords = [String]()
        
        var greens = [Int]()
        var yellows = [Int]()
        var greys = [Int]()
        var required = [Character: Int]()
        
        for i in 0..<5 {
            if colorIndexes[i] == 2 {
                greens.append(i)
                required[submittedWord.getLetter(i: i), default: 0] += 1
            }
            
            else if colorIndexes[i] == 1 {
                yellows.append(i)
                required[submittedWord.getLetter(i: i), default: 0] += 1
            }
            
            else {
                greys.append(i)
                
            }
        }
        print(greens)
        print(yellows)
        print(greys)
        
        
        
        
        var possibleWords = [String]()
        
        
        for word in allWords {
            

            var found = true
            for i in greens {
                if word.getLetter(i: i) != submittedWord.getLetter(i: i) {
                    found = false
                    break
                }
            }

            if found == false{
                continue
            }
            
            for i in yellows {
                
                if submittedWord.getLetter(i: i) == word.getLetter(i: i) || word.contains(submittedWord.getLetter(i: i)) == false {
                    found = false
                    break
                }
                                
            }
            
            if found == false{
                continue
            }
            

            
            for i in greys {
                let letterCount = word.filter{$0 == submittedWord.getLetter(i: i)}.count
                print(word, submittedWord.getLetter(i: i))
                print(letterCount, required[submittedWord.getLetter(i: i), default: 0])
                if letterCount > required[submittedWord.getLetter(i: i), default: 0] {
                    found = false
                    break
                }
            }
            
      
            
            if found {
                foundWords.append(word)
                possibleWords.append(word)
            }
            
            
        }
        
        submittedWord = ""
        colorIndexes = [0,0,0,0,0]
        
        allWords = possibleWords
        
        
        

        return foundWords
    }
}


#Preview {
    WordleSolve(allWords: getWords(), allAnswerWords: getAnswerWords())
}

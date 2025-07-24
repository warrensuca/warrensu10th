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
            colorIndex += 1
        } label: {
            ZStack{
                
                
                Rectangle()
                    .frame(width: 65, height:65)
                    .foregroundStyle(.gray)
                
                
                
                
                Rectangle()
                    .frame(width: 60, height:60)
                    .foregroundStyle(colors[colorIndex%3])
                
                
                
                
                Text("\(letter)")
                    .font(.system(size: 60))
                    .foregroundStyle(.black)
                
            }
            
        }
    }
}

struct WordleSolve: View {
    @State private var colorIndexes = [0,0,0,0,0]
    @State var word = ""
    @FocusState var focused: Bool
    @State var spellCheck = false
    var body: some View {
        VStack(alignment: .center){
            HStack{
                ForEach(0..<5, id: \.self) { i in

                    ButtonTileView(letter: getLetter(i: i), colorIndex: $colorIndexes[i])
                        
                }
                
            }
            TextField("enter word", text: $word).focused($focused, equals: true)
                
                .onAppear {
                  DispatchQueue.main.asyncAfter(deadline: .now() + 0.75) {
                      self.focused = true
                  }
                }
                .onChange(of: word) {
                    word = word.uppercased()
                }
                .autocorrectionDisabled()
                .frame(width:0,height:0)
                .onSubmit {
                    let checker = UITextChecker()
                    let range = NSRange(location: 0, length: word.utf16.count)
                    
                    
                    let tempWord = word.lowercased()
                    let misspelledRange = checker.rangeOfMisspelledWord(in: tempWord, range: range, startingAt: 0, wrap: false, language: "en")
                    let allGood = misspelledRange.location == NSNotFound

                    spellCheck = !allGood
                    self.focused = true
                    
                }
            
        }.alert("Incorrect spelling", isPresented: $spellCheck) {
            Button("Ok") { }
        } message: {
            Text("This word does not exist")
        }
        
    }
    
    func getLetter(i: Int) -> Character{

        if i >= word.count {
            return " "
        }
        else{
            let index = word.index(word.startIndex, offsetBy: i)
            return word[index]
        }
        
    }
}


#Preview {
    WordleSolve()
}

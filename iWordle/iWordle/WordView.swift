//
//  WordView.swift
//  iWordle
//
//  Created by warren su on 7/21/25.
//

import SwiftUI
struct TileView: View {
    var letter: Character
    var color: Color
    @Binding var inTransition: Bool

    
    var body: some View{
        
        ZStack{
            
            
            Rectangle()
                .frame(width: 65, height:65)
                .foregroundStyle(.gray)
                .rotation3DEffect(.degrees(inTransition ? 180: 0), axis: (x:0, y: 1, z: 0))
                
                

            Rectangle()
                .frame(width: 60, height:60)
                .foregroundStyle(.white)
                .rotation3DEffect(.degrees(inTransition ? 180: 0), axis: (x:0, y: 1, z: 0))
                .opacity(inTransition ? 0 : 1)
                
            Rectangle()
                .frame(width: 60, height: 60)
                .foregroundStyle(color)
                .rotation3DEffect(.degrees(inTransition ? 180: 0), axis: (x:0, y: 1, z: 0))
                .opacity(inTransition ? 1 : 0)
                
            
            Text("\(letter)")
                .font(.system(size: 60))
                
        }
        
    }
}
struct WordView: View {
    
    @State var word = ""
    
    var row: Int
    
    
    @State var colors = [Color.white,Color.white,Color.white,Color.white,Color.white]
    @FocusState var focused: Bool
    @Binding var gameEnd: Bool
    @Binding var currRow: Int
    @Binding var currCount: Int
    var targetWord: String
    
    @State var inTransition = false

    var body: some View {
        VStack(alignment: .center){
            HStack{
                ForEach(0..<5, id: \.self) { i in

                    TileView(letter: getLetter(i: i), color: colors[i], inTransition: $inTransition)
                        .animation(.spring(duration: 0.25, bounce: 0.5), value: word)
                }
                
            }
            TextField("enter word", text: $word).focused($focused, equals: true)
                
                .onAppear {
                  DispatchQueue.main.asyncAfter(deadline: .now() + 0.75) {
                      self.focused = currRow == row
                  }
                }
                .onChange(of: word) {
                    word = word.uppercased()
                }
                .onChange(of: currRow) {
                    self.focused = currRow == row
                }
                .autocorrectionDisabled()
                .frame(width:0,height:0)
                .onSubmit {
                    let checker = UITextChecker()
                    let range = NSRange(location: 0, length: word.utf16.count)
                    
                    
                    let tempWord = word.lowercased()
                    let misspelledRange = checker.rangeOfMisspelledWord(in: tempWord, range: range, startingAt: 0, wrap: false, language: "en")
                    let allGood = misspelledRange.location == NSNotFound

                    if word.count == 5 && allGood{
                        
                        withAnimation(.easeIn(duration: 1.5)){
                            inTransition = true
                        }
                        currRow += 1
                        colors = checkAnswer(correctWord: targetWord)

                    }
                    else {
                        self.focused = true
                    }
                }
            
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
    
    func checkAnswer(correctWord: String) -> [Color]{
        var out = [Color]()
        var letters = [Character: Int]()
        for letter in correctWord {

            letters[letter] = (letters[letter] ?? 0) + 1
        }
        
        for i in 0..<5 {
            
            let index = word.index(word.startIndex, offsetBy: i)
            print(word[index], letters[word[index]] ?? 0)
            if word[index] == correctWord[index] && letters[word[index]] ?? 0 > 0 {
                out.append(Color.green)
                currCount += 1
                letters[word[index]]! -= 1
            }
            else if correctWord.contains(word[index]) && letters[word[index]] ?? 0 > 0 {
                out.append(Color.yellow)
                letters[word[index]]! -= 1
            }
            else {
                out.append(Color.white)
            }
        }
        gameEnd = currCount == 5 || currRow == 6
        return out
    }
}

struct flipModifer: ViewModifier {
    let amount: Double
    
    func body(content: Content) -> some View {
        content
            .rotationEffect(.degrees(amount))
    }
}

extension AnyTransition {
    static var flip: AnyTransition {
        .modifier(active: flipModifer(amount: 90), identity: flipModifer(amount: 0))
    }
}

#Preview {
    WordView(row: 0, gameEnd: .constant(false), currRow: .constant(0), currCount: .constant(0), targetWord: "AGIST")
}

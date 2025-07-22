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
    
    
    
    var body: some View{
        
        ZStack{
            
            
            Rectangle()
                .frame(width: 65, height:65)
                .foregroundStyle(.gray)
            Rectangle()
                .frame(width: 60, height:60)
                .foregroundStyle(color)
            
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
    
    
    var body: some View {
        VStack(alignment: .center){
            HStack{
                ForEach(0..<5, id: \.self) { i in

                    TileView(letter: getLetter(i: i), color: colors[i])
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
                    
                    if word.count == 5{
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
        
        for i in 0..<5 {
            
            let index = word.index(word.startIndex, offsetBy: i)
            
            if word[index] == correctWord[index] {
                out.append(Color.green)
                currCount += 1
            }
            else if correctWord.contains(word[index]) {
                out.append(Color.yellow)
            }
            else {
                out.append(Color.white)
            }
        }
        gameEnd = currCount == 5 || currRow == 6
        return out
    }
}



#Preview {
    WordView(row: 0, gameEnd: .constant(false), currRow: .constant(0), currCount: .constant(0), targetWord: "HELLO")
}

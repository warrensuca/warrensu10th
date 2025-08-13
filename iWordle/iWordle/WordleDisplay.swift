//
//  WordleDisplay.swift
//  iWordle
//
//  Created by warren su on 8/12/25.
//

import SwiftUI

struct WordleDisplay: View {
    var wordDisplays: [(String, [Int])]
    var sizeMultiplier = 1.0;
    let colors = [Color.white,Color.yellow,Color.green]
    var body: some View {
        ForEach(Array(wordDisplays.enumerated()), id: \.offset) { index, item in
            let word = item.0
            let indexes = item.1
            
            
            
            
            HStack{
                ForEach(0..<5, id: \.self) { i in
                    
                    ZStack{
                        
                        
                        Rectangle()
                            .frame(width: 26*sizeMultiplier, height:26*sizeMultiplier)
                            .foregroundStyle(.gray)
                        
                        Rectangle()
                            .frame(width: 25*sizeMultiplier, height:25*sizeMultiplier)
                            .foregroundStyle(colors[indexes[i]])
                        let letter = word.getLetter(i: i)
                        Text("\(letter)")
                            .font(.system(size: 12*sizeMultiplier))
                            .foregroundStyle(.black)
                            .bold()
                        
                    }
                    
                }
                
            }
        }

    }
}

#Preview {
    WordleDisplay(wordDisplays: [("HELLO", [0,1,2,1,0])])
}

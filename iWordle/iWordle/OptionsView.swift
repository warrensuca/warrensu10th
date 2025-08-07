//
//  OptionsView.swift
//  iWordle
//
//  Created by warren su on 8/5/25.
//

import SwiftUI




struct OptionsView: View {
    var words: [String]
    var answerWords: [String]
    @State private var alertMessage = ""
    @State private var showingAlert = false
    var body: some View {
        
        let answerSet = Set(answerWords)
        let possibleAnswers = words.filter {answerSet.contains($0)}
        
        let possibleChoices = words.filter {answerSet.contains($0) == false}
        NavigationStack{
            List {
                Section("Possible Answers") {
                    ForEach(possibleAnswers, id: \.self) {word in
                        
                        Text("\(word)")
                        
                    }
                }.alert("Your word is: ", isPresented: $showingAlert) {
                    Button("Ok") {}
                } message: {
                    Text(alertMessage)
                }
            }
            
            List {
                Section("Possible Choices"){
                    ForEach(possibleChoices, id: \.self) {word in
                        
                        Text("\(word)")
                        
                    }
                }
                
                .alert("Your word is: ", isPresented: $showingAlert) {
                    Button("Ok") {}
                } message: {
                    Text(alertMessage)
                }
            }
            .toolbar {
                ToolbarItem {
                    
                    Button {
                        showingAlert = true
                        alertMessage = words.randomElement() ?? "Sorry there was an error"
                    } label: {
                        Label("Random Word", systemImage: "shuffle")
                    }
                }
            
                ToolbarItem {
                    Button {
                        showingAlert = true
                        alertMessage = possibleAnswers.randomElement() ?? "Sorry there was an error"
                    } label: {
                        Label("Random Answer", systemImage: "lightbulb")
                    }
                }
            }
        }
        
    }
}

#Preview {
    OptionsView(words: getWords(), answerWords: getAnswerWords())
}

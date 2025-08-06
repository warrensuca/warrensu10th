//
//  OptionsView.swift
//  iWordle
//
//  Created by warren su on 8/5/25.
//

import SwiftUI




struct OptionsView: View {
    var words: [String]
    @State private var alertMessage = ""
    @State private var showingAlert = false
    var body: some View {
        
        
        NavigationStack{
            List {
                ForEach((words), id: \.self) {word in
                    
                    Text("\(word)")
                    
                }.alert("Your word is: ", isPresented: $showingAlert) {
                    Button("Ok") {}
                } message: {
                    Text(alertMessage)
                }
            }
            .toolbar {
                Button("Get Random Word") {
                    showingAlert = true
                    alertMessage = words.randomElement() ?? "Sorry there was an error"
                }
            }
        }
        
    }
}

#Preview {
    OptionsView(words: getWords())
}

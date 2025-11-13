//
//  SelfInputText.swift
//  StatTwin
//
//  Created by Warren Su on 11/12/25.
//

import SwiftUI

struct SelfInputText: View {
    let attributeNames = ["PPG", "AST", "REB", "STL", "BLK", "FG%", "3P%", "%3P", "Height", "Weight"]
    let attributes: [Binding<String>]
    var body: some View {
        ForEach(0..<attributeNames.count, id: \.self) { i in
            LabeledContent("\(attributeNames[i]):") {
                TextField("Enter \(attributeNames[i])", text: attributes[i])
                    .keyboardType(.decimalPad)
                    .multilineTextAlignment(.trailing)
            }
            .padding(.vertical, 5)
        }
    }
}

#Preview {
    //SelfInputText()
}

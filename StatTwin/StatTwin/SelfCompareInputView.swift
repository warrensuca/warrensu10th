//
//  SelfCompareInputView.swift
//  StatTwin
//
//  Created by Warren Su on 10/6/25.
//

import SwiftUI

struct SelfCompareInputView: View {
    @State private var ppg = 0.0
    @State private var ast = 0.0
    @State private var reb = 0.0
    @State private var stl = 0.0
    @State private var blk = 0.0
    @State private var fgPct = 0.0
    @State private var threePoint = 0.0
    
    var body: some View {
        NavigationStack{
            let attributeNames = ["PPG", "AST", "REB", "STL", "BLK", "FG%", "3P%"]
            let attributes: [Binding<Double>] = [$ppg, $ast, $reb, $stl, $blk, $fgPct, $threePoint]
            Form{
                Section("Give them a rating 0-100") {
                    ForEach(0..<7, id: \.self) { i in
                        LabeledContent("\(attributeNames[i]): \(Int(attributes[i].wrappedValue))") {
                            VStack{
                                
                                Slider(value: attributes[i], in: 0...100, step: 1)
                                    .animation(.spring(response: 0.3, dampingFraction: 0.5), value: attributes[i].wrappedValue)
                            }
                        }.padding()
                    }
                    
                }
            }.navigationTitle("Your attributes?")
        }
        
    }
}

#Preview {
    SelfCompareInputView()
}

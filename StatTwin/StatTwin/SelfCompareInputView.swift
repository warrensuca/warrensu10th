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
    @State private var pct2Shots = 0.0
    @Binding var input_player: Player
    var body: some View {
        NavigationStack{
            let attributeNames = ["PPG", "AST", "REB", "STL", "BLK", "FG%", "3P%", "%3P"]
            let attributes: [Binding<Double>] = [$ppg, $ast, $reb, $stl, $blk, $fgPct, $threePoint, $pct2Shots]
            Form{
                Section("Give them a rating 0-100") {
                    ForEach(0..<8, id: \.self) { i in
                        LabeledContent("\(attributeNames[i]): \(Int(attributes[i].wrappedValue))") {
                            VStack{
                                
                                Slider(value: attributes[i], in: 0...100, step: 1)
                                    .animation(.spring(response: 0.3, dampingFraction: 0.5), value: attributes[i].wrappedValue)
                            }
                        }.padding()
                    }
                    .onChange(of: attributes){
                        input_player[0] = Player(id: 0000, name: "Your", points: attributes[0].wrappedValue / 2.5, assists: attributes[1].wrappedValue / 6.5, rebounds: attributes[2].wrappedValue / 6.5, steals: attributes[3].wrappedValue / 25, blocks: attributes[4].wrappedValue/25, fieldGoalPct: attributes[5].wrappedValue, threePointPct: attributes[6].wrappedValue, pct2Shots: 100-attributes[7].wrappedValue)
                    }
                    
                }
            }.navigationTitle("Your attributes?")
        }
        
    }
}

#Preview {
    @State var lebron = Player.samplePlayer
    SelfCompareInputView(input_player: $lebron)
}

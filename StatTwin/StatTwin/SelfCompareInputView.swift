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
                    
                }
            }.navigationTitle("Your attributes?")
                .onChange(of: ppg) { updatePlayer() }
                .onChange(of: ast) { updatePlayer() }
                .onChange(of: reb) { updatePlayer() }
                .onChange(of: stl) { updatePlayer() }
                .onChange(of: blk) { updatePlayer() }
                .onChange(of: fgPct) { updatePlayer() }
                .onChange(of: threePoint) { updatePlayer() }
                .onChange(of: pct2Shots) { updatePlayer() }
            }
        }
        
        
    private func updatePlayer() {
        input_player = Player(
            id: 0000,
            name: "You",
            points: ppg / 2.5,
            assists: ast / 6.5,
            rebounds: reb / 6.5,
            steals: stl / 25,
            blocks: blk / 25,
            fieldGoalPct: fgPct,
            threePointPct: threePoint,
            pct2Shots: 100 - pct2Shots
        )
    }
}

#Preview {
    @State var lebron = Player.samplePlayer
    SelfCompareInputView(input_player: $lebron)
}

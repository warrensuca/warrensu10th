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
    var limits = [50.0, 25.0, 25.0, 5, 5, 100, 100, 100]
    var steps = [0.5, 0.5, 0.5, 0.1, 0.1, 1, 1, 1,1]
    var body: some View {
        NavigationStack{
            let attributeNames = ["PPG", "AST", "REB", "STL", "BLK", "FG%", "3P%", "%3P"]
            let attributes: [Binding<Double>] = [$ppg, $ast, $reb, $stl, $blk, $fgPct, $threePoint, $pct2Shots]
            Form{
                Section("Enter in your stats!") {
                    ForEach(0..<8, id: \.self) { i in
                        
                            LabeledContent("\(attributeNames[i]): \(Int(attributes[i].wrappedValue))") {
                                
                                ZStack{
                                    Slider(value: attributes[i], in: 0.0...limits[i], step: steps[i])
                                        .animation(.spring(response: 0.3, dampingFraction: 0.5), value: attributes[i].wrappedValue)
                                    HStack{
                                        ForEach(0..<10, id: \.self) { i in
                                            Rectangle()
                                                .frame(width:2, height: 8)
                                            Spacer()
                                        }
                                    }
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
            points: ppg,
            assists: ast,
            rebounds: reb,
            steals: stl ,
            blocks: blk ,
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

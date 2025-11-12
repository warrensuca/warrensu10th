//
//  SelfCompareInputView.swift
//  StatTwin
//
//  Created by Warren Su on 10/6/25.
//

import SwiftUI

private func statSlider(label: String, value: Binding<Double>, start: Double, limit: Double, step: Double) -> some View {
        LabeledContent("\(label): \(Int(value.wrappedValue))") {
            Slider(value: value, in: start...limit, step: step)
                .animation(.spring(response: 0.3, dampingFraction: 0.5), value: value.wrappedValue)
        }
        .padding()
    }

struct SelfCompareInputView: View {
    @State private var ppg = 0.0
    @State private var ast = 0.0
    @State private var reb = 0.0
    @State private var stl = 0.0
    @State private var blk = 0.0
    @State private var fgPct = 0.0
    @State private var threePoint = 0.0
    @State private var pct2Shots = 0.0
    @State private var height = 60.0
    @State private var weight = 150.0
    @Binding var input_player: Player
    var starts = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 60, 150.0]
    var limits = [50.0, 25.0, 25.0, 5, 5, 100, 100, 100, 96, 350.0]
    var steps = [0.5, 0.5, 0.5, 0.1, 0.1, 1, 1, 1, 1, 1]
    var body: some View {
        NavigationStack{
            let attributeNames = ["PPG", "AST", "REB", "STL", "BLK", "FG%", "3P%", "%3P", "Height", "Weight"]
            let attributes: [Binding<Double>] = [$ppg, $ast, $reb, $stl, $blk, $fgPct, $threePoint, $pct2Shots, $height, $weight]
            Form{
                Section("Enter in your stats!") {
                    ForEach(0..<10, id: \.self) { i in
                        
                            LabeledContent("\(attributeNames[i]): \(Int(attributes[i].wrappedValue))") {
                                
                                ZStack{
                                    
                                    
                                    Slider(value: attributes[i], in: starts[i]...limits[i], step: steps[i])
                                        .animation(.spring(response: 0.3, dampingFraction: 0.5), value: attributes[i].wrappedValue)
                                    HStack{
                                        ForEach(0..<10, id: \.self) { j in
                                            Rectangle()
                                                .frame(width:2, height: 8)
                                           Spacer()
                                        }
                                    }
                                }
                                
                                
                            }.padding()
                            
                        
                    }
                    
                }
                HStack{
                    Image("\(input_player.id)")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 120)
                        .clipShape(Capsule())
                        .shadow(radius: 10)
                    
                    Text("\(input_player.name) - \(Int(input_player.height/12))'\(Int(input_player.height)%12)")
                }
                RoundedRectangle(cornerRadius: 100)
                    .frame(width:5, height:200)
                    .foregroundStyle(.gray)
                    
                VStack() {
                    let attributeNames = ["PPG", "AST", "REB", "STL", "BLK", "FG%", "3P%", "%2Shots"]
                    let attributes = [input_player.points, input_player.assists, input_player.rebounds, input_player.steals, input_player.blocks, input_player.fieldGoalPct, input_player.threePointPct, input_player.pct2Shots]
                    ForEach(0..<7, id: \.self) { i in
                        VStack{
                            //String(format: "%.1f", statValues[i])
                            Text("\(attributeNames[i]): \(String(format: "%.1f", attributes[i]))")
                        }
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
                .onChange(of: height) { updatePlayer() }
                .onChange(of: weight) { updatePlayer() }
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
            pct2Shots: 100 - pct2Shots,
            height: height,
            weight: weight
            
        )
    }
}

#Preview {
    @State var lebron = Player.samplePlayer
    SelfCompareInputView(input_player: $lebron)
}

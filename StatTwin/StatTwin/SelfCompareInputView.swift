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
    
    @State private var is_slider = true
    
    @State private var refreshID = UUID()
    var body: some View {
        NavigationStack{
            //let attributeNames = ["PPG", "AST", "REB", "STL", "BLK", "FG%", "3P%", "%3P", "Height", "Weight"]
            let attributes: [Binding<Double>] = [$ppg, $ast, $reb, $stl, $blk, $fgPct, $threePoint, $pct2Shots, $height, $weight]
            Form{
                Section("Enter in your stats!") {
                        if(is_slider) {
                            SelfInputSlider(attributes: attributes)
                                .padding()
                        } else {
                            SelfInputText(attributes: attributes.map { doubleToStringBinding($0) })
                                .padding()
                        }
                    
                    }
                PlayerCard(input_player: $input_player)
                    .id(refreshID)
                    
                    
                }
            .navigationTitle("Your attributes?")
            .onChange(of: ppg) { update() }
            .onChange(of: ast) { update() }
            .onChange(of: reb) { update() }
            .onChange(of: stl) { update() }
            .onChange(of: blk) { update() }
            .onChange(of: fgPct) { update() }
            .onChange(of: threePoint) { update() }
            .onChange(of: pct2Shots) { update() }
            .onChange(of: height) { update() }
            .onChange(of: weight) { update() }
            .toolbar {
                Toggle("", isOn: $is_slider)
            }
                
                    
                    
            }
                
                
            }
        
        
    private func doubleToStringBinding(_ doubleBinding: Binding<Double>) -> Binding<String> {
        Binding<String>(
            get: { String(format: "%.1f", doubleBinding.wrappedValue) },
            set: { newValue in
                if let doubleValue = Double(newValue) {
                    doubleBinding.wrappedValue = doubleValue
                }
            }
        )
    }
    private func update() {
        input_player = Player(
            id: 0000,
            name: "You",
            points: Double(ppg),
            assists: Double(ast),
            rebounds: Double(reb),
            steals: Double(stl) ,
            blocks: Double(blk) ,
            fieldGoalPct: Double(fgPct),
            threePointPct: Double(threePoint),
            pct2Shots: Double(100 - pct2Shots),
            height: Double(height),
            weight: Double(weight)
            
        )
        refreshID = UUID()
    }
}
struct PlayerCard: View {
    @Binding var input_player: Player
    var body: some View {
        HStack(){
            VStack{
                Image("no_pfp")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 120)
                    .clipShape(Capsule())
                    .shadow(radius: 10)
                
                Text("\(input_player.name) - \(Int(input_player.height/12))'\(Int(input_player.height)%12)")
            }
            .padding()
            
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
        }
    }
}

#Preview {
    @State var lebron = Player.samplePlayer
    SelfCompareInputView(input_player: $lebron)
}

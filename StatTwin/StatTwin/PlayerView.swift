//
//  PlayerView.swift
//  StatTwin
//
//  Created by Warren Su on 10/8/25.
//

import SwiftUI

struct PlayerView: View {
    var player_id: Int
    var players: [Player]
    var body: some View {
            
    
        HStack(){
            let player = players.first(where: { $0.id == player_id })!
            Image("\(player.id)")
                .resizable()
                .scaledToFit()
                .frame(height: 120)
                .clipShape(Capsule())
            RoundedRectangle(cornerRadius: 100)
                .frame(width:5, height:200)
                .foregroundStyle(.gray)
                
            VStack() {
                let attributeNames = ["PPG", "AST", "REB", "STL", "BLK", "FG%", "3P%", "%2Shots"]
                let attributes = [player.points, player.assists, player.rebounds, player.steals, player.blocks, player.fieldGoalPct*100, player.threePointPct*100, player.pct2Shots]
                ForEach(0..<7, id: \.self) { i in
                    VStack{
                        Text("\(attributeNames[i]): \(attributes[i].formatted())")
                    }
                }
            }
        }
            

        
    }
}

#Preview {
    PlayerView(player_id: 2544, players: loadPlayers())
}

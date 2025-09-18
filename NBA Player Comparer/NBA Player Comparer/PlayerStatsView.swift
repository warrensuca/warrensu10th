//
//  PlayerStatsView.swift
//  NBA Player Comparer
//
//  Created by warren su on 8/29/25.
//

import SwiftUI


extension Color {
        static let primaryBrandColor = Color(red: 0.1, green: 0.3, blue: 0.5)
        static let accentGreen = Color(red: 0.2, green: 0.6, blue: 0.3)
    }



struct PlayerStatsView: View {
    var player: Player
    var colorList: [Color]
    init(player: Player, colorList: [Color]) {
        self.player = player
        self.colorList = colorList
        
        
        
    }
    var body: some View {
        NavigationStack {
            
            
            VStack{
                Image("\(player.id)")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 100)
                    
                    
                
                Text("\(player.name)")
                    .font(.title2)
                
                
                let playerAttributes = [player.points, player.assists, player.rebounds, player.steals, player.blocks, player.fieldGoalPct, player.threePointPct]
                
                let stats = ["PPG", "AST", "REB", "STL", "BLK", "FG%", "3FG%"]
                ForEach(0..<5, id: \.self) {i in
                    ZStack {
                        Rectangle()
                            .foregroundStyle(colorList[i])
                            .shadow(radius: 10)
                            .frame(width:60, height:60)
                            
                        VStack{
                            Text("\(playerAttributes[i].formatted())")
                            
                                .font(.custom("Sprintura", size: 20))
                            Spacer()
                                .frame(height:10)
                            Text("\(stats[i])")
                            
                                .font(.custom("Ruigslay", size: 15))
                            
                        }
                        
                    }
                    Spacer()
                        .frame(height:15)
                }
            }
        }
    }
}

#Preview {
    PlayerStatsView(player: .samplePlayer, colorList: [Color.green, Color.green, Color.green, Color.accentGreen, Color.red, ])
}

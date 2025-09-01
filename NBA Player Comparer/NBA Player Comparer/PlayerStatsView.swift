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
    
    var body: some View {
        NavigationStack {
            Text("\(player.fullName)")
                .font(.title2)
            
            var playerAttributes = [player.points, player.assists, player.rebounds, player.steals, player.blocks]

            var stats = ["PPG", "AST", "REB", "STL", "BLK"]
            ForEach(0..<5, id: \.self) {i in
                ZStack {
                    Rectangle()
                        .foregroundStyle(colorList[i])
                        .frame(width:80, height:80)
                    VStack{
                        Text("\(playerAttributes[i].formatted())")
                        
                            .font(Font.custom("Ruigslay", size: 30))
                        Spacer()
                            .frame(height:10)
                        Text("\(stats[i])")
                        
                            .font(Font.custom("Ruigslay", size: 15))
                    }
                    
                }
                Rectangle()
                    .frame(height:3)
                    .foregroundStyle(.gray)
            }

        }
    }
}

#Preview {
    PlayerStatsView(player: .samplePlayer, colorList: [Color.green, Color.green, Color.green, Color.accentGreen, Color.red, ])
}

//
//  PlayerStatsView.swift
//  NBA Player Comparer
//
//  Created by warren su on 8/29/25.
//

import SwiftUI

struct PlayerStatsView: View {
    var player: Player
    
    
    var body: some View {
        Text("\(player.name)")
            .font(.title2)
        
        var playerAttributes = [player.points, player.assists, player.rebounds, player.steals, player.blocks]
        List{
            ForEach(playerAttributes, id: \.self) {attribute in
                VStack {
                    Text("\(attribute)")
                }
            }
        }
    }
}

#Preview {
    PlayerStatsView()
}

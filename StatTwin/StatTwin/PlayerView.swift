//
//  PlayerView.swift
//  StatTwin
//
//  Created by Warren Su on 10/8/25.
//

import SwiftUI

struct PlayerView: View {
    var player: Player
    var body: some View {
        HStack(){
            Image("\(player.id)")
                .resizable()
                .scaledToFit()
                .frame(height: 120)
        }.clipShape(Capsule())
    }
}

#Preview {
    PlayerView(player: Player.samplePlayer)
}

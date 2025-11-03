//
//  PlayerCompareInput.swift
//  StatTwin
//
//  Created by Warren Su on 10/21/25.
//

import SwiftUI

struct PlayerCompareInput: View {

    var players = loadPlayers()
    
    @State private var isExpanded = false
    

    @Environment(\.dismiss) var dismiss
    
    @State private var searchText = ""
    
    
    @Binding var input_player: Player
    
    private var filteredPlayers: [Player] {
        if searchText.isEmpty {
            players
        }
        else {
            players.filter {$0.name.localizedStandardContains(searchText)}
        }
    }
    
    
    var body: some View {
        NavigationStack {
            
            
            List(filteredPlayers, selection: $input_player) {player in
                DisclosureGroup(player.name) {
                    VStack{
                        PlayerView(player_id: player.id)
                    }
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 15)
                            .fill(Color(UIColor.systemGray6))
                            .shadow(radius: 5)
                    )
                }
            }
            .navigationTitle("Searching")
            
            
        }.searchable(text: $searchText, prompt: "Searching for something")
    }

}

#Preview {
    @State var lebron = Player.samplePlayer
    SelfCompareInputView(input_player: $lebron)
}

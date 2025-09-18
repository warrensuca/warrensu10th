//
//  ChoosePlayersView.swift
//  NBA Player Comparer (Mac)
//
//  Created by Warren Su on 9/14/25.
//

import SwiftUI

struct ChoosePlayersView: View {
    var playerNames: [String]
    
    //@Binding var selectedPlayer: Player
    @State private var selectedPlayer = 0
    @Environment(\.dismiss) var dismiss
    var totalPlayers: [Player]
    @Binding var playerList: [Player]
    @State private var searchText = ""
    var filteredNames: [String] {
        if searchText.isEmpty {
            playerNames
        }
        else {
            playerNames.filter {$0.localizedStandardContains(searchText)}
        }
}
    var body: some View {
        NavigationStack {
            VStack{
                Button("Selection for Player \(selectedPlayer )") {
                    selectedPlayer = 1 - selectedPlayer
                }
            }
            
            List(filteredNames, id: \.self) {name in
                Button(action: {
                    
                    if let player = totalPlayers.first(where: { $0.name == name }) {
                        playerList[selectedPlayer] = player
                    }
                    dismiss()
                })
                {
                    Text(name)
                }
            }
            .searchable(text: $searchText, prompt: "Searching for something")
            .navigationTitle("Searching")
        }
    }
}



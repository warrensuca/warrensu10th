//
//  ChoosePlayersView.swift
//  NBA Player Comparer (Mac)
//
//  Created by Warren Su on 9/14/25.
//

import SwiftUI

struct ChoosePlayersView: View {
    var playerNames: [String]
    
    @Binding var selectedPlayer: Player
    
    var players: [Player]
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
            List(filteredNames, id: \.self) {name in
                Button(action: {
                    
                    if let player = players.first(where: { $0.name == name }) {
                        selectedPlayer = player
                    }
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



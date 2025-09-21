//
//  ContentView.swift
//  NBA Player Comparer (Mac)
//
//  Created by Warren Su on 9/10/25.
//

import SwiftUI
import PythonKit

struct ContentView: View {
    var players = loadPlayers()
    
    
    @State private var currentPlayers = [Player.samplePlayer, Player.samplePlayer];
    
    @State var showingSheet = false
    
    
    var body: some View {
        NavigationStack {
            HStack{
                @State var colorLists = getColorCodes(player1: currentPlayers[0], player2: currentPlayers[1])
                PlayerStatsView(player: currentPlayers[0], colorList: colorLists[0])
                Rectangle()
                    .frame(width:5)
                PlayerStatsView(player: currentPlayers[1], colorList: colorLists[1])
            }
            .toolbar {
                ToolbarItemGroup {
                    Button() {
                        showingSheet.toggle()
                    } label: {
                        Image(systemName: "plus.circle.fill")
                    }
                    
                    
                }
            }
            .sheet(isPresented: $showingSheet) {
                ChoosePlayersView(
                    playerNames: players.map { $0.name },
                    totalPlayers: players,
                    playerList: $currentPlayers
                    
                    
                )
            }
            
        
        }
    }
}

func getColorCodes(player1: Player, player2: Player) -> [[Color]] {
    let attributes1 = [
        player1.points,
        player1.assists,
        player1.rebounds,
        player1.steals,
        player1.blocks,
        player1.fieldGoalPct,
        player1.threePointPct
    ]
    
    let attributes2 = [
        player2.points,
        player2.assists,
        player2.rebounds,
        player2.steals,
        player2.blocks,
        player2.fieldGoalPct,
        player2.threePointPct
    ]
    
    var colors1: [Color] = []
    var colors2: [Color] = []
    
    for i in 0..<attributes1.count {
        if attributes1[i] > attributes2[i] {
            colors1.append(.green)
            colors2.append(.red)
        } else if attributes1[i] < attributes2[i] {
            colors1.append(.red)
            colors2.append(.green)
        } else { // tie
            colors1.append(.gray)
            colors2.append(.gray)
        }
    }
    
    return [colors1, colors2]
}


func loadPlayers() -> [Player] {
    
    guard let url = Bundle.main.url(forResource: "stats", withExtension: "json") else {
        print("❌ stats.json not found")
        return []
    }
    do {
        let data = try Data(contentsOf: url)
        let players = try JSONDecoder().decode([Player].self, from: data)
        return players
    } catch {
        print("❌ Failed to decode stats.json: \(error)")
        return []
    }
    
}


#Preview {
    ContentView()
}

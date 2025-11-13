//
//  ContentView.swift
//  StatTwin
//
//  Created by Warren Su on 10/6/25.
//

import SwiftUI

struct ContentView: View {
    @State var input_player = Player.samplePlayer 
    var players = loadPlayers()
    var body: some View {
        TabView {
            SelfCompareInputView(input_player: $input_player)
            .tabItem {
                Label("Self Input",
                      systemImage: "1.circle")
                
                
            }

            PlayerCompareInput(players: players, input_player: $input_player)
            .tabItem {
                Label("Player Input",
                      systemImage: "2.circle")
                
            }
            ResultView(basePlayer: $input_player, players: loadPlayers())
                
            .tabItem {
                Label("Results",
                      systemImage: "2.circle")
                
                }
        }
    
        
    }
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
func load_STD_players() -> [Player] {
    guard let url = Bundle.main.url(forResource: "std_scaled_stats", withExtension: "json") else {
        print("❌ std_scaled_stats.json not found")
        return []
    }
    do {
        let data = try Data(contentsOf: url)
        let players = try JSONDecoder().decode([Player].self, from: data)
        return players
    } catch {
        print("❌ Failed to decode std_scaled_stats.json: \(error)")
        return []
    }
}
#Preview {
    ContentView()
}

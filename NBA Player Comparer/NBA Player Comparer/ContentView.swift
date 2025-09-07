//
//  ContentView.swift
//  NBA Player Comparer
//
//  Created by warren su on 8/29/25.
//

import SwiftUI




struct ContentView: View {
    
    @State private var players = [Player]()
    var body: some View {
        VStack {
            
        }
        .task {
                await fetchPlayer()
            }
        .padding()
    }
    
    func fetchPlayer() async {
        
        
        guard let url = URL(string: "https://api.balldontlie.io/nba/v1/season_averages/general?season=2024&season_type=regular&type=base")
        else {
            print("INVALID URL")
            return
        }
        var request = URLRequest(url: url)
        request.setValue("Bearer d6ef2975-ca51-4738-9459-e46020c7a402", forHTTPHeaderField: "Authorization")

                             
        struct StatsResponse: Codable {
            let data: [StatData]
        }
        
        struct StatData: Codable {
            let player: Player
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            if let jsonString = String(data: data, encoding: .utf8) {
                    print("RAW RESPONSE:\n\(jsonString)")
                }
            if let decodedResponse = try?
                
                JSONDecoder().decode(StatsResponse.self, from: data) {
                players = decodedResponse.data.map{$0.player}
                print("Loaded \(players.count) players")
                    for player in players {
                        print(player.fullName)
                    }
            }
            
        } catch {
            print("INVALID DATA")
        }
        
        
        
        
        
        
    }
}

#Preview {
    ContentView()
}

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
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .task {
                await fetchPlayer()
            }
        .padding()
    }
    
    func fetchPlayer() async {
        var results = [Player]()
        
        guard let url = URL(string: "https://api.balldontlie.io/v1/stats")
        else {
            print("INVALID URL")
            return
        }
        
        struct StatsResponse: Codable {
            let data: [StatData]
        }
        
        struct StatData: Codable {
            let player: Player
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            if let decodedResponse = try?
                
                JSONDecoder().decode(StatsResponse.self, from: data) {
                players = decodedResponse.data.map{$0.player}
            }
            
        } catch {
            print("INVALID DATA")
        }
        
        
        
        
        
        
    }
}

#Preview {
    ContentView()
}

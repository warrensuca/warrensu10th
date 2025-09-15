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
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
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


#Preview {
    ContentView()
}

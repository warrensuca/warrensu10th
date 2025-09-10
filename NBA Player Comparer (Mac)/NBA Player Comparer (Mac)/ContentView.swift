//
//  ContentView.swift
//  NBA Player Comparer (Mac)
//
//  Created by Warren Su on 9/10/25.
//

import SwiftUI
import PythonKit

struct ContentView: View {
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

func createAllPlayers() -> PythonObject {
    
    let sys = Python.import("sys")
    sys.path().append("/Users/warrensu/Programming/warrensu10th/NBA Player Comparer (Mac)")
    let file = Python.import("NBA_API_Scraping")
    let all_ids = fetchAllPlayerIDs()
    var players = [PythonObject]
    for id
}
#Preview {
    ContentView()
}

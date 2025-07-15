//
//  ContentView.swift
//  Moonshot
//
//  Created by warren su on 7/6/25.
//

import SwiftUI

struct ContentView: View {
    
    let astronauts: [String: Astronaut] =  Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    
    @State private var showingGrid = true
    @State private var notCurViewName = "List"
    var body: some View {
        NavigationStack{
            
            Group {
                if showingGrid {
                    ScrollLayout(astronauts: astronauts, missions: missions)
                } else {
                    ListLayout(astronauts: astronauts, missions: missions)
                }
            }
            .navigationTitle("Moonshot")
            .background(.darkBackground)
            .toolbar {
                ToolbarItem{
                    Button("Toggle \(notCurViewName) View") {
                        showingGrid.toggle()
                        notCurViewName = showingGrid ? "List" : "Scroll"
                    }
                }
            }
            
        }
    }
}

#Preview {
    ContentView()
}

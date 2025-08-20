//
//  ContentView.swift
//  SnowSeeker
//
//  Created by warren su on 8/1/25.
//

import SwiftUI

struct ContentView: View {
    let resorts: [Resort] = Bundle.main.decode("resorts.json")
    
    @State private var favorites = Favorites()
    @State private var searchText = ""
    
    var filteredResorts: [Resort] {
        if searchText.isEmpty {
            return resorts
        } else {
            return resorts.filter { $0.name.localizedStandardContains(searchText) }
        }
    }

    
    @State private var sortProperty = 0
    
    var sortedResorts: [Resort] {
        switch sortProperty {
        case 1:
            return resorts.sorted { $0.name < $1.name }
        case 2:
            return resorts.sorted { $0.country < $1.country }
        default:
            return resorts
        }
    }
    var body: some View {
        NavigationSplitView {
            List(sortedResorts) { resort in
                NavigationLink(value: resort) {
                    HStack {
                        Image(resort.country)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 40, height: 25)
                            .clipShape(.rect(cornerRadius: 5))
                            .overlay(
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(.black, lineWidth: 1)
                                    
                            )
                        VStack(alignment: .leading) {
                            Text(resort.name)
                                .font(.headline)
                            Text("\(resort.runs) runs")
                                .foregroundStyle(.secondary)
                        }
                        
                        if favorites.contains(resort) {
                            Spacer()
                            Image(systemName: "heart.fill")
                                .accessibilityLabel("This is a favorite resort")
                                .foregroundStyle(.red)
                            
                            
                        }
                        
                    }
                }
            }
            .toolbar {
                Menu("Sort", systemImage: "arrow.up.arrow.down") {
                    Picker("Sort Order", selection: $sortProperty) {
                        Text("Default")
                            .tag(0)
                        Text("Alphabetical")
                            .tag(1)
                        Text("Country")
                            .tag(2)
                    }
                    
                }
            }
            .navigationTitle("SnowSeeker")
            .navigationDestination(for: Resort.self) {resort in
                ResortView(resort: resort)
            }
            .searchable(text: $searchText, prompt: "Search for a resort")
            
        } detail: {
            Text("Detail")
        }
        .environment(favorites)
    }
}

#Preview {
    Text("Test")
    //ContentView()
}

//
//  ContentView.swift
//  Bookworm
//
//  Created by Warren Su on 7/18/25.
//
import SwiftData
import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    @Query var books: [Book]
    
    @State private var showingSheet = false
    var body: some View {
        NavigationStack {
            List {
                ForEach(books) {book in
                    NavigationLink(value: book) {
                        HStack {
                            EmojiRatingView(rating: book.rating)
                                .font(.largeTitle)
                            VStack(alignment: .leading) {
                                Text(book.title)
                                    .font(.headline)
                                
                                Text(book.author)
                                    .foregroundStyle(.secondary)
                            }
                        }
                    }
                }
            }
            
            Text("Count: \(books.count)")
                .navigationTitle("Bookworm")
                .toolbar {
                    ToolbarItem {
                        Button("Add Book") {
                            showingSheet.toggle()
                        }
                    }
                }
                .sheet(isPresented: $showingSheet) {
                    AddBookView()
                }
        }
    }
}

#Preview {
    ContentView()
}


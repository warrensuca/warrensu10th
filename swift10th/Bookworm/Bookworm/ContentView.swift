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
    @Query(sort: [SortDescriptor(\Book.rating, order: .reverse)]) var books: [Book]
    
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
                                    .foregroundStyle(book.rating == 1 ? .red : .black)
                                
                                Text(book.author)
                                    .foregroundStyle(.secondary)
                            }
                        }
                    }
                }
                
                .onDelete(perform: deleteBooks)
                
                
            }
            
            .navigationDestination(for: Book.self) {book in  DetailView(book: book)}
            .navigationTitle("Bookworm")
            .toolbar {
                ToolbarItem {
                    Button("Add Book ") {
                        showingSheet.toggle()
                    }
                }
                ToolbarItem(placement: .topBarLeading) {
                    EditButton()
                }
            }
            .sheet(isPresented: $showingSheet) {
                AddBookView()
            }
        }
    }
    func deleteBooks(at offsets: IndexSet) {
        for offset in offsets {
            // find this book in our query
            let book = books[offset]

            // delete it from the context
            modelContext.delete(book)
        }
    }
}


#Preview {
    ContentView()
}


//
//  AddBook.swift
//  Bookworm
//
//  Created by Warren Su on 7/18/25.
//

import SwiftUI

struct AddBookView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    
    @State private var title = ""
    @State private var author = ""
    @State private var rating = 3
    @State private var genre = "Fantasy"
    @State private var review = ""
    
    let genres = ["Fantasy", "Horror", "Kids", "Mystery", "Poetry", "Romance", "Thriller"]
    
    
    
    var body: some View {
        NavigationStack{
            Form {
                Section {
                    TextField("Name of book", text: $title)
                    
                    TextField("Name of author", text: $author)
                    
                    Picker("Genre", selection: $genre) {
                        ForEach(genres, id: \.self) {
                            Text($0)
                        }
                    }
                }
                Section("Review: "){
                    TextEditor(text: $review)
                    HStack{
                        RatingView(rating: $rating)
                        Spacer()
                        EmojiRatingView(rating: rating)
                    }
                }
            }
            .toolbar{
                let newBook = Book(title: title, author: author, genre: genre, review: review, rating: rating)
                
                Button("Save") {
                    
                    print(DateFormatter().string(from: newBook.date))
                    modelContext.insert(newBook)
                    try? modelContext.save()
                    dismiss()
                }.disabled(newBook.isValid == false)
            
            }
            .navigationTitle("Bookworm")
        }
    }
}

#Preview {
    AddBookView()
}

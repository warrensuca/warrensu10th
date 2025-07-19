//
//  Book.swift
//  Bookworm
//
//  Created by Warren Su on 7/18/25.
//
import SwiftData
import SwiftUI

@Model
class Book {
    var title: String
    var author: String
    var genre: String
    var review: String
    var rating: Int
    
    init(Title: String, author: String, genre: String, review: String, rating: Int) {
        self.title = Title
        self.author = author
        self.genre = genre
        self.review = review
        self.rating = rating
    }
}

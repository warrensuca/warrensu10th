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
    
    var date = Date.now
    
    init(title: String, author: String, genre: String, review: String, rating: Int) {
        self.title = title
        self.author = author
        self.genre = genre
        self.review = review
        self.rating = rating
        self.date = Date.now
    }
    private var letters = ["a","b","c","d","e","f","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z"]
    
    private var digits = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "0"]

    var isValid: Bool {

        var titleValid = false
        var authorValid = false
        for letter in letters {
            if title.contains(letter) || title.contains(letter.uppercased()){
                titleValid = true
                break
            }
        }
        
        for letter in letters {
            if author.contains(letter) || author.contains(letter.uppercased()){
                authorValid = true
                break
            }
        }
        
        for digit in digits {
            if title.contains(digit){
                titleValid = true
                break
            }
        }
        
        
        for digit in digits {
            if author.contains(digit){
                authorValid = true
                break
            }
        }
        return titleValid && authorValid
    }

}

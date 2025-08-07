//
//  Card.swift
//  Flashzilla
//
//  Created by warren su on 7/30/25.
//
import Foundation
import SwiftData

@Model
class Card: Identifiable {
    var id = UUID()
    var prompt: String
    var answer: String
    var correct = true
    init(prompt: String, answer: String) {
        self.prompt = prompt
        self.answer = answer
    }

    init(card: Card) {
        prompt = card.prompt
        answer = card.answer
    }

    static let example = Card(prompt: "What is Swift?", answer: "A high-level programming language.")
}

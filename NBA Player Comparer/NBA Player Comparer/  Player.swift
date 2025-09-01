//
//    Player.swift
//  NBA Player Comparer
//
//  Created by warren su on 8/29/25.
//

import Foundation

@Observable
class Player: Codable, Identifiable {
    enum CodingKeys: String, CodingKey {
        case _firstName = "first_name"
        case _lastName = "last_name"
        case _points = "Points"
        case _assists = "Assists"
        case _rebounds = "Rebounds"
        case _steals = "Steals"
        case _blocks = "Blocks"
    }
    let id = UUID()
    var firstName: String
    var lastName: String
    var points: Double
    var assists: Double
    var rebounds: Double
    var steals: Double
    var blocks: Double
    
    var fullName: String {
            "\(firstName) \(lastName)"
        }
    
    init(firstName: String, lastName: String, points: Double, assists: Double, rebounds: Double, steals: Double, blocks: Double) {
        self.firstName = firstName
        self.lastName = lastName
        self.points = points
        self.assists = assists
        self.rebounds = rebounds
        self.steals = steals
        self.blocks = blocks
        
    }
    static let samplePlayer = Player(
            firstName: "LeBron",
            lastName: "James",
            points: 27.1,
            assists: 7.4,
            rebounds: 7.5,
            steals: 1.6,
            blocks: 0.8
        )
}

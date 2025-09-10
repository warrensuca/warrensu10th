//
//    Player.swift
//  NBA Player Comparer
//
//  Created by warren su on 8/29/25.
//

import Foundation


class Player: Codable, Identifiable {
    
        
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
    enum CodingKeys: String, CodingKey {
            case id
            case firstName = "first_name"
            case lastName = "last_name"
            case points = "pts"
            case assists = "ast"
            case rebounds = "reb"
            case steals = "stl"
            case blocks = "blk"
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
    static func == (lhs: Player, rhs: Player) -> Bool {
           lhs.id == rhs.id
       }
}

//
//  Player.swift
//  StatTwin
//
//  Created by Warren Su on 10/6/25.
//

import Foundation
import Foundation


class Player: Codable {
    
        
    
    let id: Int
    let name: String
    let imageURL: String
    let points: Double
    let rebounds: Double
    let assists: Double
    let steals: Double
    let blocks: Double
    let fieldGoalPct: Double
    let threePointPct: Double
    let pct2Shots: Double
    let pct3Shots: Double
    init(id: Int, name: String, imageURL: String, points: Double, rebounds: Double, assists: Double, steals: Double, blocks: Double, fieldGoalPct: Double, threePointPct: Double, pct2Shots: Double, pct3Shots: Double) {
            self.id = id
            self.name = name
            self.imageURL = imageURL
            self.points = points
            self.rebounds = rebounds
            self.assists = assists
            self.steals = steals
            self.blocks = blocks
            self.fieldGoalPct = fieldGoalPct
            self.threePointPct = threePointPct
            self.pct2Shots = pct2Shots / 100
            self.pct3Shots = pct3Shots / 100
        }
    
    static let samplePlayer = Player(
            id: 2544,
            name: "LeBron James",
            imageURL: "https://cdn.nba.com/headshots/nba/latest/1040x760/2544.png",
            points: 24.4,
            rebounds: 7.8,
            assists: 8.2,
            steals: 1.0,
            blocks: 0.6,
            fieldGoalPct: 0.513,
            threePointPct: 0.376,
            pct2Shots: 77.1,
            pct3Shots: 22.9,
        )
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case imageURL
        case points = "PPG"
        case rebounds = "RPG"
        case assists = "AST"
        case steals = "STL"
        case blocks = "BLK"
        case fieldGoalPct = "FG%"
        case threePointPct = "3P%"
        case pct2Shots = "%2Shots"
        case pct3Shots = "%3Shots"
    }
    
    static func == (lhs: Player, rhs: Player) -> Bool {
           lhs.id == rhs.id
       }
}

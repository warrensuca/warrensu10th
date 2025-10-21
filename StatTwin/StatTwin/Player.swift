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
    
    let points: Double
    let assists: Double
    let rebounds: Double
    let steals: Double
    let blocks: Double
    let fieldGoalPct: Double
    let threePointPct: Double
    let pct2Shots: Double
    
    init(id: Int, name: String, points: Double, assists: Double, rebounds: Double, steals: Double, blocks: Double, fieldGoalPct: Double, threePointPct: Double, pct2Shots: Double) {
            self.id = id
            self.name = name
            self.points = points
            self.assists = assists
            self.rebounds = rebounds
            self.steals = steals
            self.blocks = blocks
            self.fieldGoalPct = fieldGoalPct
            self.threePointPct = threePointPct
            self.pct2Shots = pct2Shots
            
        }
    
    static let samplePlayer = Player(
            id: 2544,
            name: "LeBron James",
            points: 24.4,
            assists: 8.2,
            rebounds: 7.8,
            steals: 1.0,
            blocks: 0.6,
            fieldGoalPct: 0.513,
            threePointPct: 0.376,
            pct2Shots: 77.1
           
        )
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case points = "PPG"
        case assists = "AST"
        case rebounds = "RPG"
        case steals = "STL"
        case blocks = "BLK"
        case fieldGoalPct = "FG%"
        case threePointPct = "3P%"
        case pct2Shots = "%2Shots"

    }
    
    static func == (lhs: Player, rhs: Player) -> Bool {
           lhs.id == rhs.id
       }
}

//
//    Player.swift
//  NBA Player Comparer
//
//  Created by warren su on 8/29/25.
//

import Foundation


class Player: Codable {
    
        
    
    let id: Int                  // from JSON "id"
    let name: String             // from JSON "name"
    let imageURL: String            // from JSON "imageURL"
    let points: Double           // from JSON "PPG"
    let rebounds: Double         // from JSON "RPG"
    let assists: Double          // from JSON "AST"
    let steals: Double           // from JSON "STL"
    let blocks: Double           // from JSON "BLK"
    let fieldGoalPct: Double     // from JSON "FG%"
    let threePointPct: Double    // from JSON "3P%"

    init(id: Int, name: String, imageURL: String, points: Double, rebounds: Double, assists: Double, steals: Double, blocks: Double, fieldGoalPct: Double, threePointPct: Double) {
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
        }
    
    static let samplePlayer = Player(
            id: 2544,
            name: "LeBron James",
            imageURL: "https://cdn.nba.com/headshots/nba/latest/1040x760/2544.png",
            points: 27.1,
            rebounds: 7.5,
            assists: 7.4,
            steals: 1.6,
            blocks: 0.8,
            fieldGoalPct: 0.505,
            threePointPct: 0.345
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
    }
    
    static func == (lhs: Player, rhs: Player) -> Bool {
           lhs.id == rhs.id
       }
}

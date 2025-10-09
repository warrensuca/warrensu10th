//
//  SelfCompareResultView.swift
//  StatTwin
//
//  Created by Warren Su on 10/7/25.
//

import SwiftUI

struct SelfCompareResultView: View {
    var basePlayer: Player
    var players = loadPlayers()
    var std_players = load_STD_players()
    
    
    
    
    var body: some View {
        var closestPlayer = findPlayer(basePlayer: basePlayer, players: std_players)
        
    }
}

func findPlayer(basePlayer: Player, players: [Player]) -> Player {
    var closestPlayer = players[2544]
    var closestValue = 0.0
    for player in players {
        let v1 = playerToVector(player: basePlayer)
        let v2 = playerToVector(player: player)
        let currVal = comparePlayer(v1: v1, v2: v2)
        if (currVal > closestValue) {
            closestValue = currVal
            closestPlayer = player
        }
        
    }
    return closestPlayer
}

func playerToVector(player: Player) -> [Double]{
    return [player.points, player.assists, player.rebounds, player.steals, player.blocks, player.fieldGoalPct, player.threePointPct]
}
func comparePlayer(v1: [Double], v2: [Double]) -> Double {
    //vector projection cosine similarity
    
    
    
    
    var vProjectionSimilarity = dotProduct(v1: v1, v2: v2)/(getMagnitude(v: v1) * getMagnitude(v: v2))

    //euclidean distance

    var temp = [Double]()
    for i in 0..<v1.count {
        temp.append(v1[i]-v2[i])
    }
    var euclideanSimilarity = 1 / (1 + getMagnitude(v: temp))
    return 0.8 * vProjectionSimilarity + 0.2 * euclideanSimilarity

}
func dotProduct(v1: [Double], v2: [Double]) -> Double {
    //helper function
    var out = 0.0
    for i in 0..<v1.count {
        out += v1[i]*v2[i]
    }
    return out
}

func getMagnitude(v: [Double]) -> Double {
    //helper function
    return Double(v.reduce(0, +)).squareRoot()
}
#Preview {
    SelfCompareResultView(basePlayer: Player.samplePlayer)
}

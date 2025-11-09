//
//  SelfCompareResultView.swift
//  StatTwin
//
//  Created by Warren Su on 10/7/25.
//

import SwiftUI

struct ResultView: View {
    var basePlayer: Player
    var players: [Player]
    var std_players = load_STD_players()
    
    @State var closestPlayerId: Int?
            
    
        
    @State var closestPlayer: Player?
    @State var similarityScore: Double?
    
    
    var body: some View {
        NavigationStack{
            ScrollView {
                VStack(spacing: 30) {
                    VStack(spacing: 15){
                        Text(basePlayer.name == "You" ? "Your most similar player is:" : "\(basePlayer.name)'s most similar player is:" )
                            .font(.headline)
                            .foregroundColor(.secondary)
                        Text((closestPlayer ?? Player.samplePlayer).name)
                            .font(.title)
                            .bold()
                    }.padding()
                    
                    
                    Spacer()
                    VStack{
                        PlayerView(player_id: closestPlayerId ?? Player.samplePlayer.id, players: players)
                    }
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 15)
                            .fill(Color(UIColor.systemGray6))
                            .shadow(radius: 5)
                    )
                    
                    Spacer()
                    
                    
                    VStack {
                        Text("Similarity Score")
                            .font(.headline)
                            .foregroundColor(.secondary)
                        Text("\(String(format: "%.2f", (similarityScore ?? 0.0)*100))%")
                            .font(.largeTitle)
                            .bold()
                            .foregroundColor(.blue)
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(
                        RoundedRectangle(cornerRadius: 15)
                            .fill(Color(UIColor.systemGray6))
                            .shadow(radius: 5)
                    )
                    .padding(.horizontal)
                }
            }.onAppear() {
                closestPlayerId = findPlayerId(basePlayer: basePlayer, players: std_players)
                
                closestPlayer = players.first(where: { $0.id == closestPlayerId})!
                
                let v1 = playerToVector(player: basePlayer, std_players: std_players)
                let v2 = playerToVector(player: closestPlayer ?? Player.samplePlayer, std_players: std_players)
                similarityScore = comparePlayer(v1: v1, v2: v2)
                
                print(comparePlayer(v1: playerToVector(player: Player.samplePlayer, std_players: std_players), v2: playerToVector(player: Player.samplePlayer2, std_players: std_players)))
            }
        }
    }
    
}

func findPlayerId(basePlayer: Player, players: [Player]) -> Int {
    var closestPlayer = players[0]
    var closestValue = 0.0
    let v1 = playerToVector(player: basePlayer, std_players: players)
    for player in players {
        if(player != basePlayer) {
            
            
            let v2 = playerToVector(player: player, std_players: players)
            let currVal = comparePlayer(v1: v1, v2: v2)
            if (currVal > closestValue) {
                closestValue = currVal
                closestPlayer = player
            }
        }
        
    }
    return closestPlayer.id
}

func playerToVector(player: Player, std_players: [Player]) -> [Double]{
    //standardize then create vector
    var standardized_player = player
    for p in std_players {
    
        if (player.id == p.id) {
            
            standardized_player = p
        }
        
    }
    
    return [standardized_player.points, standardized_player.assists, standardized_player.rebounds, standardized_player.steals, standardized_player.blocks, standardized_player.fieldGoalPct, standardized_player.threePointPct]
}
func comparePlayer(v1: [Double], v2: [Double]) -> Double {
    //vector projection cosine similarity
    
    
    
    
    let vProjectionSimilarity = dotProduct(v1: v1, v2: v2)/(getMagnitude(v: v1) * getMagnitude(v: v2))

    //euclidean distance

    var temp = [Double]()
    for i in 0..<v1.count {
        temp.append(v1[i]-v2[i])
    }
    let euclideanSimilarity = 1 / (1 + getMagnitude(v: temp))
    return 0.75 * vProjectionSimilarity + 0.25 * euclideanSimilarity

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
    
    return sqrt(v.reduce(0) { $0 + $1 * $1 })
}
#Preview {
    ResultView(basePlayer: Player.samplePlayer, players: loadPlayers())
}

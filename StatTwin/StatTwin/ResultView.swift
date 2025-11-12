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
                calculateSimilarity()
                
            }
            .onChange(of: basePlayer.id) {
                calculateSimilarity()
            }
            .onChange(of: basePlayer.points) {
                calculateSimilarity()
            }
            .onChange(of: basePlayer.assists) {
                calculateSimilarity()
            }
            .onChange(of: basePlayer.rebounds) {
                calculateSimilarity()
            }
            .onChange(of: basePlayer.steals) {
                calculateSimilarity()
            }
            .onChange(of: basePlayer.blocks) {
                calculateSimilarity()
            }
            .onChange(of: basePlayer.fieldGoalPct) {
                calculateSimilarity()
            }
            .onChange(of: basePlayer.threePointPct) {
                calculateSimilarity()
            }
            .onChange(of: basePlayer.pct2Shots) {
                calculateSimilarity()
            }
            .onChange(of: basePlayer.height) {
                calculateSimilarity()
            }
            .onChange(of: basePlayer.weight) {
                calculateSimilarity()
            }
        
            
        }
    }
    func calculateSimilarity(){
        closestPlayerId = findPlayerId(basePlayer: basePlayer, players: std_players)
        
        closestPlayer = players.first(where: { $0.id == closestPlayerId})!
        
        var v1 = playerToVector(player: basePlayer, std_players: std_players)
        if(basePlayer.id == 0000) {
            v1 = playerToVector(player: basePlayer)
        }
        
        
        let v2 = playerToVector(player: closestPlayer ?? Player.samplePlayer, std_players: std_players)
        print(v1, v2)
        similarityScore = comparePlayer(v1: v1, v2: v2)
        
        print(comparePlayer(v1: playerToVector(player: Player.samplePlayer, std_players: std_players), v2: playerToVector(player: Player.samplePlayer2, std_players: std_players)))
    }
    
}


func findPlayerId(basePlayer: Player, players: [Player]) -> Int {
    var closestPlayer = players[0]
    var closestValue = 0.0
    var v1 = playerToVector(player: basePlayer, std_players: players)
    if(basePlayer.id == 0000) {
        v1 = playerToVector(player: basePlayer)
    }
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
func playerToVector(player: Player) -> [Double] {
    
    //avg for stats
    //{'PPG': 9.36, 'RPG': 3.76, 'AST': 2.17, 'STL': 0.71, 'BLK': 0.43, 'FG%': 0.45, '3P%': 0.31, '%2Shots': 0.65}
    
    //std for stats
    //{'PPG': 6.23, 'RPG': 2.31, 'AST': 1.78, 'STL': 0.41, 'BLK': 0.4, 'FG%': 0.09, '3P%': 0.13, '%2Shots': 0.24}
    
    //avg and std for builds
    //{'Height': 77.39, 'Weight': 215.2}
    //{'Height': 3.37, 'Weight': 23.21}
    
    let avg = [9.36, 2.17, 3.76, 0.71, 0.43, 0.45, 0.31, 0.65, 77.39, 215.2]
    let std = [6.23, 1.78, 2.31, 0.41, 0.4, 0.09, 0.13, 0.24, 3.37, 23.21]
    var out = [player.points, player.assists, player.rebounds, player.steals, player.blocks, player.fieldGoalPct/100, player.threePointPct/100, player.pct2Shots/100, player.height, player.weight]
    for i in 0..<out.count {
        out[i] = (out[i]-avg[i])/std[i]
    }
    return out
    
}

func playerToVector(player: Player, std_players: [Player]) -> [Double]{
    //standardize then create vector
    var standardized_player = player
    for p in std_players {
    
        if (player.id == p.id) {
            
            standardized_player = p
        }
        
    }
    
    return [standardized_player.points, standardized_player.assists, standardized_player.rebounds, standardized_player.steals, standardized_player.blocks, standardized_player.fieldGoalPct, standardized_player.threePointPct, standardized_player.pct2Shots, standardized_player.height, standardized_player.weight]
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

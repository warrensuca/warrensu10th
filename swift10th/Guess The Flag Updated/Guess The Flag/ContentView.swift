//
//  ContentView.swift
//  Guess The Flag
//
//  Created by warren su on 4/17/25.
//

import SwiftUI

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var score = 0
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var runs = 0
    @State private var finalAlert = false
    
    @State private var rotationAmount = [Double](repeating: 0.0, count: 3)
    @State private var opacityAmount = [Double](repeating: 1.0, count: 3)
    var body: some View {
        NavigationView{
            ZStack{
                LinearGradient(colors: [.orange, .purple], startPoint: .top, endPoint: .bottom).ignoresSafeArea()

                    
                VStack{
                    VStack(spacing:30) {
                        VStack {
                            Text("Tap the flag of ").foregroundStyle(.white).font(.subheadline.weight(.heavy))
                            Text(countries[correctAnswer]).foregroundStyle(.white).font(.largeTitle.weight(.semibold))
                        }
                            
                        }
                    VStack(spacing:30){
                        ForEach(0..<3) {
                            number in Button {
                                flagTapped(number)
                                withAnimation{
                                    rotationAmount[number] += 360
                                    for num in 0..<3 {
                                        if num != number {
                                            opacityAmount[num] = 0
                                        }
                                    }
                                }
                            }
                            
                            label: {
                                Image(countries[number]).clipShape(.capsule).shadow(radius: 10)
                            }
                            .opacity(opacityAmount[number])
                            .rotation3DEffect(.degrees(rotationAmount[number]), axis: (x: 0.0, y: 1.0, z: 0.0))
                        }
                        
                    }
                    .frame(maxWidth: .infinity)
                       .padding(.vertical, 20)
                        .background(.regularMaterial)
                        .clipShape(.rect(cornerRadius: 20))
                    
                    Text("Score: \(score)").foregroundStyle(.white).font(.largeTitle.bold())
                }
                    
            }.alert(scoreTitle, isPresented: $showingScore) {
                Button("Continue", action: askQuestion)
                    } message: {
                            Text("Your score is \(score)")
                        }
            
                    .alert("Your final score \(score)", isPresented: $finalAlert){
                        Button("Reset game?", action: resetGame)
                    }
        }.navigationTitle("Guess the Flag")
        
        
            
    }
    func flagTapped(_ number:Int){
        if number == correctAnswer {
            scoreTitle = "Correct"
            score += 1
        }
        else {
            scoreTitle = "Wrong, That's the flag of \(countries[number])"
        }
        showingScore = true
    }
    
    func askQuestion() {
        rotationAmount = [0,0,0]
            

        opacityAmount = [1.0, 1.0, 1.0]
        
        runs += 1
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        if runs == 8 {
            runs = 0
            finalAlert = true
        }
    }
    func resetGame(){
        score = 0
    }
}

#Preview {
    ContentView()
}

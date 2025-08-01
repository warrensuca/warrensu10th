//
//  ContentView.swift
//  iDice
//
//  Created by warren su on 7/31/25.
//
import SwiftData
import SwiftUI



struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    
    @Query var Dice: [Die]
    var sides = [4,6,8,10,12,20,100]
    let timer = Timer.publish(every: 0.2, on: .main, in: .common).autoconnect()
    @State private var stopRolling = true
    
    @State private var currSidesNum = 6
    @State private var result = 6
    @State private var counter = 0
    var body: some View {
        NavigationStack{
            VStack {
                Text(stopRolling ? "You rolled a \(result)" : "Rolling... \(result)")
                    .font(.title)
            }.toolbar {
                Menu("Sort", systemImage: "arrow.up.arrow.down") {
                    Picker("Sides", selection: $currSidesNum) {
                        ForEach(sides, id: \.self) { num in
                            Text("\(num) sides")
                        }
                    }
                }
                Button("Roll") {
                    stopRolling = false
                }
                .sensoryFeedback(.impact(flexibility: .rigid, intensity: 0.5), trigger: stopRolling)

            }
            .onReceive(timer) { time in
                
                
                if counter == 5 {
                    let currDie = Die(value: result)
                    modelContext.insert(currDie)
                    try? modelContext.save()
                    stopRolling = true
                    counter = 0
                }
                if stopRolling == false {
                    roll()
                    
                    counter += 1
                }
            }

        }
        
    }
    
    func roll() {
        result = Int.random(in: 1...currSidesNum)
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Die.self)
}

//
//  ContentView.swift
//  Flashzilla
//
//  Created by warren su on 7/30/25.
//
import SwiftData
import SwiftUI
extension View {
    func stacked(at position: Int, in total: Int) -> some View {
        let offset = Double(total-position)
        return self.offset(y: offset*10)
    }
}


struct ContentView: View {
    @Environment(\.accessibilityDifferentiateWithoutColor) var accessibilityDifferentiateWithoutColor
    @Environment(\.accessibilityVoiceOverEnabled) var accessibilityVoiceOverEnabled
    @Environment(\.scenePhase) var scenePhase
    @Environment(\.modelContext) var modelContext

    @State private var isActive = true
    @Query private var cards: [Card]
    @State private var showingEditScreen = false
    
    
    @State private var timeRemaining = 100
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    var body: some View {
        ZStack{
            Image(decorative: "background")
                .resizable()
                .ignoresSafeArea()
            
            VStack {
                Text("Timer: \(timeRemaining)")
                    .font(.largeTitle)
                    .foregroundStyle(.white)
                    .padding()
                    .background(.black.opacity(0.75))
                    .clipShape(.capsule)
                
                ZStack{
                    ForEach(Array(cards.enumerated()), id: \.element.id) { index, card in
                        CardView(card: card) {
                            
                            
                            withAnimation {

                                removeCard(card: card)
     
                            }
                        }
                            .stacked(at: index, in: cards.count)
                            .allowsHitTesting(index == cards.count - 1)
                            .accessibilityHidden(index < cards.count - 1)
                    }
                    
                }
                if cards.isEmpty {
                    Button("Start Again") {
                        resetCards()
                    }
                    .padding()
                    .background(.white)
                    .foregroundStyle(.black)
                    .clipShape(.capsule)
                }
            }
            .allowsHitTesting(timeRemaining > 0)
            
            
            VStack {
                HStack {
                    Spacer()

                    Button {
                        showingEditScreen = true
                    } label: {
                        Image(systemName: "plus.circle")
                            .padding()
                            .background(.black.opacity(0.7))
                            .clipShape(.circle)
                    }
                }

                Spacer()
            }
            .foregroundStyle(.white)
            .font(.largeTitle)
            .padding()
            if accessibilityDifferentiateWithoutColor || accessibilityVoiceOverEnabled{
                VStack {
                    Spacer()

                    HStack {
                        Button {
                            withAnimation {
                                removeCard(card: cards.last)
                            }
                        } label: {
                            Image(systemName: "xmark.circle")
                                .padding()
                                .background(.black.opacity(0.7))
                                .clipShape(.circle)
                        }
                        .accessibilityLabel("Wrong")
                        .accessibilityHint("Mark your answer as being incorrect.")

                        Spacer()

                        Button {
                            withAnimation {
                                removeCard(card: cards.last)
                            }
                        } label: {
                            Image(systemName: "checkmark.circle")
                                .padding()
                                .background(.black.opacity(0.7))
                                .clipShape(.circle)
                        }
                        .accessibilityLabel("Correct")
                        .accessibilityHint("Mark your answer as being correct.")
                    }
                }
            }
        }
        .onReceive(timer) { time in
            if isActive {
                timeRemaining = max(0, timeRemaining-1)
            }
        }
        
        .onChange(of: scenePhase) {
            //isActive = scenePhase == .active
            
            if scenePhase == .active && cards.isEmpty == false {
                isActive = true
            }
            else {
                isActive = false
            }
            
        }
        .sheet(isPresented: $showingEditScreen, onDismiss: resetCards) {
            EditCards()
        }
        
        
    }

    
    func removeCard(card: Card?) {
        guard let card else { return }
        print("yes \(card.correct)")
        modelContext.delete(card)

        if card.correct == false {
            let newCard = Card(prompt: card.prompt, answer: card.answer)
            modelContext.insert(newCard)
        }

        try? modelContext.save()
        if cards.isEmpty {
            isActive = false
        }

    }
    
    func resetCards() {

        timeRemaining = 100
        isActive = true

    }
}

#Preview {
    ContentView()
}

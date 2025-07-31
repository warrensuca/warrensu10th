//
//  CardView.swift
//  Flashzilla
//
//  Created by warren su on 7/30/25.
//

import SwiftUI

struct CardView: View {
    @State private var offset = CGSize.zero
    @State private var front = true
    @State private var slidingBack = false
    @Environment(\.accessibilityDifferentiateWithoutColor) var accessibilityDifferentiateWithoutColor
    @Environment(\.accessibilityVoiceOverEnabled) var accessibilityVoiceOverEnabled
    let card: Card
    
    var removal: (() -> Void)? = nil
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25)
                .fill(
                    accessibilityDifferentiateWithoutColor ? .white :
                    .white
                        .opacity(1-Double(abs(offset.width / 50)))
                    )
                .background (
                    accessibilityDifferentiateWithoutColor ? nil :
                    RoundedRectangle(cornerRadius: 25)
                        .fill(slidingBack ? (offset.width > 0 ? .green : .red) : (offset.width < 0 ? .red : .green))
                )
                .shadow(radius:10)
            
            VStack{
                if accessibilityVoiceOverEnabled {
                    Text(front ? card.prompt : card.answer)
                        .font(.largeTitle)
                        .foregroundStyle(.black)
                } else {
                    Text(card.prompt)
                        .font(.largeTitle)
                        .foregroundStyle(.black)
                        .opacity(front ? 1 : 0)
                    Text(card.answer)
                        .font(.title)
                        .foregroundStyle(.secondary)
                        .opacity(front ? 0 : 1)
                }
                
            }
            .padding(20)
            .multilineTextAlignment(.center)
        }
        .frame(width: 450, height: 250)
        .rotationEffect(.degrees(offset.width/5.0))
        .offset(x: offset.width * 5)
        .opacity(2-Double(abs(offset.width / 50)))
        .accessibilityAddTraits(.isButton)
        .gesture(
            DragGesture()
                .onChanged { gesture in
                    offset = gesture.translation
                    slidingBack = false
                }
                .onEnded { _ in
                    if abs(offset.width) > 100 {
                        removal?()
                    }
                    else {
                        slidingBack = true
                        offset = .zero
                    }
                }
            )
        .onTapGesture {
            front.toggle()
        }
        .animation(.bouncy, value: offset)
        
    }
}

#Preview {
    CardView(card: .example)
}

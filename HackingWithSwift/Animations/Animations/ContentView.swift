//
//  ContentView.swift
//  Animations
//
//  Created by warren su on 6/24/25.
//

import SwiftUI


struct CornerRotatedModifier: ViewModifier {
    let amount: Double
    let anchor: UnitPoint
    
    func body(content: Content) -> some View{
        content
            .rotationEffect(.degrees(amount), anchor: anchor)
            .clipped()
    }
}

extension AnyTransition {
    static var pivot: AnyTransition {
        .modifier(active: CornerRotatedModifier(amount: -90, anchor:  .topLeading), identity: CornerRotatedModifier(amount:0 , anchor: .topLeading))
    }
}

struct ContentView: View {
    let letters = Array("Hello SwiftUI")
    
    @State private var isShowingRed = false
    var body: some View {
        ZStack {
            Rectangle()
                .fill(.blue)
                .frame(width: 200, height: 200)
            if isShowingRed{
                Rectangle()
                    .fill(.red)
                    .frame(width: 200, height: 200)
                    .transition(.pivot)
            }
        }
        .onTapGesture {
            withAnimation {
                isShowingRed.toggle()
            }
        }
    }
        
}

#Preview {
    ContentView()
}

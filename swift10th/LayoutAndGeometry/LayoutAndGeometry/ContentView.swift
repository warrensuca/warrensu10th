//
//  ContentView.swift
//  LayoutAndGeometry
//
//  Created by warren su on 7/31/25.
//

import SwiftUI

struct ContentView: View {
    let colors: [Color] = [.red, .green, .blue, .orange, .pink, .purple, .yellow]

    var body: some View {
        GeometryReader { fullView in
            ScrollView(.vertical) {
                ForEach(0..<50) { index in
                    GeometryReader { proxy in
                        let y = (proxy.frame(in: .global).minY)/150
                        let scale = max(0.25, (proxy.frame(in: .global).minY)/880)
                        Text("Row #\(index)")
                            
                            .frame(maxWidth: .infinity)
                            .background(Color(hue: (proxy.frame(in: .global).minY)/880, saturation: (proxy.frame(in: .global).minY)/880, brightness: (proxy.frame(in: .global).minY)/880))
                            .rotation3DEffect(.degrees(proxy.frame(in: .global).minY - fullView.size.height / 2) / 5, axis: (x: 0, y: 1, z: 0))
                            .opacity(max(0, (min(1, y-1))))
                            .font(.title)
                            .scaleEffect(scale)
                    }.frame(height: 40)

                    
                }
            }
        }
    }
}

#Preview {
    ContentView()
}

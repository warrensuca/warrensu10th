//
//  SelfInputSlider.swift
//  StatTwin
//
//  Created by Warren Su on 11/12/25.
//

import SwiftUI

struct SelfInputSlider: View {
    var starts = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 60, 150.0]
    var limits = [50.0, 25.0, 25.0, 5, 5, 100, 100, 100, 96, 350.0]
    var steps = [0.5, 0.5, 0.5, 0.1, 0.1, 1, 1, 1, 1, 1]
    let attributeNames = ["PPG", "AST", "REB", "STL", "BLK", "FG%", "3P%", "%3P", "Height", "Weight"]
    let attributes: [Binding<Double>]
    var body: some View {
        ForEach(0..<10, id: \.self) { i in
            
            LabeledContent("\(attributeNames[i]): \(Int(attributes[i].wrappedValue))") {
                
                ZStack{
                    
                    
                    Slider(value: attributes[i], in: starts[i]...limits[i], step: steps[i])
                        .animation(.spring(response: 0.3, dampingFraction: 0.5), value: attributes[i].wrappedValue)
                    HStack{
                        ForEach(0..<10, id: \.self) { j in
                            Rectangle()
                                .frame(width:2, height: 8)
                            Spacer()
                        }
                    }
                }
                
                
            }
        }
    }
}

#Preview {
    //SelfInputSlider()
}

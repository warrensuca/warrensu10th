//
//  RatingView.swift
//  Bookworm
//
//  Created by Warren Su on 7/18/25.
//

import SwiftUI

struct RatingView: View {
    @Binding var rating: Int
    var label = ""
    var maximumRating = 5
    
    var offImage: Image?
    var onImage = Image(systemName: "star.fill")
    
    var offColor = Color.gray
    var onColor = Color.yellow
    
    var body: some View {
        HStack{
            if label.isEmpty {
                Text(label)
            }
            
            ForEach(1..<6, id: \.self) { number in
                Button {
                    rating = number
                } label: {image(for: number)}.foregroundStyle(number <= rating ? onColor : offColor)
                
            }.buttonStyle(.plain)
        }
    }
    
    func image(for number: Int) -> Image {
        if number <= rating {
            return offImage ?? onImage
        }
        else {
            return onImage
        }
    }
}

#Preview {
    RatingView(rating: .constant(4))
}

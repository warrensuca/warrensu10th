//
//  ScrollLayout.swift
//  Moonshot
//
//  Created by warren su on 7/9/25.
//

import SwiftUI

struct ScrollLayout: View {
    let astronauts: [String: Astronaut]
    let missions: [Mission]
    
    
    let columns = [
        GridItem(.adaptive(minimum: 150))
    ]
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns) {
                ForEach(missions) { mission in
                    NavigationLink {
                        MissionView(mission: mission, astronauts: astronauts)
                    } label: {
                        VStack{
                            Image(mission.image)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 100)
                            VStack{
                                Text(mission.displayName)
                                    .font(.headline)
                                    .foregroundStyle(.white)
                                Text(mission.formattedLaunchDate)
                                    .font(.caption)
                                    .foregroundStyle(.gray)
                                
                            }
                            .padding(.vertical)
                            .frame(maxWidth: .infinity)
                            .background(.lightBackground)
                        }
                        .clipShape(.rect(cornerRadius: 10))
                        .overlay(
                            RoundedRectangle(cornerRadius:10)
                                .stroke(.lightBackground)
                        )
                    }
                    
                }
            }
            .padding([.horizontal, .bottom])
        }
    }
}

#Preview {
    
    let astronauts: [String: Astronaut] =  Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    ListLayout(astronauts: astronauts, missions: missions ).preferredColorScheme(.dark)
}

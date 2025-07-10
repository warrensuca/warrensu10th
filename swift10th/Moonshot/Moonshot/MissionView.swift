//
//  MissionView.swift
//  Moonshot
//
//  Created by warren su on 7/9/25.
//

import SwiftUI

struct CrewMember {
    let role: String
    let astronaut: Astronaut
    
}

struct MissionView: View {
    let mission: Mission
    let crew: [CrewMember]

    
    
    var body: some View {
        NavigationStack{
            ScrollView {
                VStack {
                    Image(mission.image)
                        .resizable()
                        .scaledToFit()
                        .containerRelativeFrame(.horizontal) {width, axis in
                            width * 0.6
                        }
                }
                VStack(alignment: .leading) {
                    Text("Launch Date: \(mission.formattedLaunchDate)")
                        .font(.title)
                }
                .padding()
                VStack(alignment: .leading) {
                    Text("Mission Highlights")
                        .font(.title.bold())
                        .padding(.bottom, 5)
                    Text(mission.description)
                    
                    Rectangle()
                        .frame(height: 2)
                        .foregroundStyle(.lightBackground)
                        .padding(.vertical)
                    
                    Text("Crew")
                        .font(.title.bold())
                        .padding(.bottom, 5)
                }
                .foregroundStyle(.white)
                .padding(.horizontal)
                
                
                AstronautDisplayView(crew: crew)
            }
            .padding(.bottom)
        }
        .navigationTitle(mission.displayName)
        .navigationBarTitleDisplayMode(.inline)
        .background(.darkBackground)
    }
    
    init(mission: Mission, astronauts: [String: Astronaut]) {
        self.mission = mission
        
        self.crew = mission.crew.map { member in
            if let astronaut = astronauts[member.name] {
                return CrewMember(role: member.role, astronaut: astronaut)
            } else {
                fatalError("Missing \(member.name)")
            }
        }
    }
}

#Preview {
    let missions: [Mission] = Bundle.main.decode("missions.json")
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    return MissionView(mission: missions[0], astronauts: astronauts)
            .preferredColorScheme(.dark)
}

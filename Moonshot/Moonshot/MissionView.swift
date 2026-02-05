//
//  MissionView.swift
//  Moonshot
//
//  Created by niccho on 4/11/2025.
//

import SwiftUI

struct Divider: View {
    var body: some View {
        Rectangle()
            .frame(height: 2)
            .foregroundStyle(.lightBackground)
            .padding(.vertical)
    }
}

struct CrewMember {
    let role: String
    let astronaut: Astronaut
}

struct MissionView: View {
    let mission: Mission
    let crew: [CrewMember]

    init(mission: Mission, astronauts: [String: Astronaut]) {
        self.mission = mission
        crew = mission.crew.map { member in
            if let astronaut = astronauts[member.name] {
                return CrewMember(role: member.role, astronaut: astronaut)
            } else {
                fatalError("Missing \(member.name)")
            }
        }
    }

    var body: some View {
        ScrollView {
            VStack {
                Image(mission.imageName)
                    .resizable()
                    .scaledToFit()
                    .containerRelativeFrame(.horizontal) { width, _ in
                        width * 0.7
                    }
                Divider()

                VStack(alignment: .leading, spacing: 10) {
                    Text(mission.fullLaunchDate)
                        .font(.headline)

                    Text("Mission Highlights")
                        .font(.title.bold())

                    Text(mission.description)
                    Divider()

                    Text("Crew")
                        .font(.title.bold())
                }
                .padding(.horizontal)

                CrewView(crew: crew)
            }
            .padding(.vertical)
        }
        .navigationTitle(mission.displayName)
        .navigationBarTitleDisplayMode(.inline)
        .background(.darkBackground)
    }
}

#Preview {
    let missions: [Mission] = Bundle.main.decode("missions.json")
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")

    return MissionView(mission: missions[1], astronauts: astronauts)
        .preferredColorScheme(.dark)
}

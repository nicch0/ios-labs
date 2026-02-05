//
//  MissionPreviewView.swift
//  Moonshot
//
//  Created by niccho on 8/11/2025.
//
import SwiftUI


struct MissionPreviewListItemView: View {
    let mission: Mission
    
    var body: some View {
        VStack {
            Image(mission.imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .padding()
            VStack {
                Text(mission.displayName)
                    .font(.headline)
                    .foregroundStyle(.white)
                Text(mission.abbreviatedLaunchDate)
                    .font(.caption)
                    .foregroundStyle(.white.opacity(0.5))
            }
            .padding(.vertical)
            .frame(maxWidth: .infinity)
            .background(.lightBackground)
        }
        .clipShape(.rect(cornerRadius: 10))
        .overlay(
            RoundedRectangle(cornerRadius: 10).stroke(.lightBackground)
        )
    }
}

#Preview {
    let missions: [Mission] = Bundle.main.decode("missions.json")
    MissionPreviewListItemView(mission:  missions[0])
}

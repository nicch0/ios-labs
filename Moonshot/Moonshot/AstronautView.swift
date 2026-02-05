//
//  AstronautView.swift
//  Moonshot
//
//  Created by niccho on 4/11/2025.
//

import SwiftUI

struct AstronautView: View {
    var astronaut: Astronaut
    @Binding var path: NavigationPath

    var body: some View {
        ScrollView {
            VStack {
                Image(astronaut.id)
                    .resizable()
                    .scaledToFit()
                    .containerRelativeFrame(.horizontal) { width, _ in
                        width * 0.7
                    }
                    .clipShape(.circle)
                    .overlay(Circle().strokeBorder(.white, lineWidth: 1))

                Divider()

                Text(astronaut.description)
                    .padding(.horizontal)
                
                Button("Go Home", systemImage: "house") {
                    path = NavigationPath()
                }
            }
            .padding([.top, .bottom])
        }
        .background(.darkBackground)
        .navigationTitle(astronaut.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    @Previewable @State var navigationPath = NavigationPath()
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")

    return AstronautView(astronaut: astronauts["aldrin"]!, path: $navigationPath)
        .preferredColorScheme(.dark)
}

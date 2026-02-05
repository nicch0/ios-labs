//
//  ContentView.swift
//  Moonshot
//
//  Created by niccho on 4/11/2025.
//

import SwiftUI

struct MissionGridLayoutView: View {
    let missions: [Mission]
    let columns = [GridItem(.adaptive(minimum: 150))]

    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns) {
                ForEach(missions) { mission in
                    NavigationLink(value: mission) {
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
            }
            .padding([.horizontal, .bottom])
        }
    }
}

struct MissionListLayoutView: View {
    let missions: [Mission]

    var body: some View {
        List {
            ForEach(missions) { mission in
                ZStack {
                    HStack {
                        Image(mission.imageName)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                            .padding()

                        HStack {
                            VStack(alignment: .leading) {
                                Text(mission.displayName)
                                    .font(.title2.bold())
                                    .foregroundStyle(.white)
                                Text(mission.abbreviatedLaunchDate)
                                    .font(.headline)
                                    .foregroundStyle(.white.opacity(0.5))
                            }
                            .padding(.leading)
                            Spacer()
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(.lightBackground)
                    }
                    .clipShape(.rect(cornerRadius: 10))
                    .overlay(
                        RoundedRectangle(cornerRadius: 10).stroke(.lightBackground)
                    )

                    // Secret trick to have navigation in your links without the navigation icon
                    NavigationLink(value: mission) {
                        EmptyView()
                    }
                    .opacity(0)
                }
            }
            .listRowBackground(Color.darkBackground)
            .listRowSeparator(.hidden)
            .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
            .padding([.horizontal, .bottom])
        }
        .listStyle(.plain)
    }
}

struct ContentView: View {
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    
    @State private var navigationPathStore = NavigationPathStore()

    @State private var viewType = "list"

    var body: some View {
        NavigationStack(path: $navigationPathStore.path) {
            Group {
                if viewType == "grid" {
                    MissionGridLayoutView(
                        missions: missions,
                    )
                } else if viewType == "list" {
                    MissionListLayoutView(missions: missions)
                }
            }
            .navigationDestination(for: Mission.self) { mission in
                MissionView(mission: mission, astronauts: astronauts)
            }
            .navigationDestination(for: Astronaut.self, destination: { astronaut in
                AstronautView(astronaut: astronaut, path: $navigationPathStore.path)
            })
            .navigationTitle("Moonshot")
            .navigationBarTitleDisplayMode(.large)
            .background(.darkBackground)
            .preferredColorScheme(.dark)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Picker("View Type", selection: $viewType) {
                        Text("Grid").tag("grid")
                        Text("List").tag("list")
                    }.pickerStyle(.segmented)
                }
            }
        }
    }
}

#Preview {
    ContentView()
}

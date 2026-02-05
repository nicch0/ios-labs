//
//  ContentView.swift
//  PhaseAnimations
//
//  Created by niccho on 28/11/2025.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            Tab("Flippin", systemImage: "card") {
                NavigationStack {
                    FrontBackCardView()
                }
            }
            Tab("Shiny", systemImage: "star") {
                NavigationStack {
                    ShinyStartView()
                }
            }
            Tab("Cal AI", systemImage: "apple.logo") {
                NavigationStack {
                    WithAndWithoutView()
                }
            }
            Tab("Staggered", systemImage: "stairs") {
                NavigationStack {
                    StaggeredEntryView()
                }
            }
            Tab("Graphs", systemImage: "graph.2d") {
                NavigationStack {
                    GraphEntryView()
                }
            }
            Tab("Love", systemImage: "heart") {
                NavigationStack {
                    ChooseLoveView()
                }
            }
            Tab("Orbit", systemImage: "moon.stars.fill") {
                NavigationStack {
                    OrbitView()
                }
            }
            Tab("Squash and Stretch", systemImage: "flame") {
                NavigationStack {
                    BasicKeyframeView()
                }
            }
        }
    }
}

#Preview {
    ContentView()
}

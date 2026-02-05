//
//  ContentView.swift
//  HotProspects
//
//  Created by niccho on 25/11/2025.
//
import SwiftData
import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            ProspectsView(filter: .none)
                .tabItem {
                    Label("Everyone", systemImage: "person.3")
                }
            ProspectsView(filter: .contacted)
                .tabItem {
                    Label("Contacted", systemImage: "checkmark.circle")
                }
            ProspectsView(filter: .uncontacted)
                .tabItem {
                    Label("Uncontacted", systemImage: "questionmark.diamond")
                }
            MeView()
                .tabItem {
                    Label("Me", systemImage: "person.crop.square")
                }
        }
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Prospect.self, configurations: config)

        for example in Prospect.examples {
            container.mainContext.insert(example)
        }
        return ContentView().modelContainer(container)
    } catch {
        return Text("Failed to create preview")
    }
}

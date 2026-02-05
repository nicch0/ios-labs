//
//  PlacesPlusFacesApp.swift
//  PlacesPlusFaces
//
//  Created by niccho on 23/11/2025.
//

import SwiftUI
import SwiftData

@main
struct PlacesPlusFacesApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: Post.self)
        }
    }
}

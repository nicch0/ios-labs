//
//  HotProspectsApp.swift
//  HotProspects
//
//  Created by niccho on 25/11/2025.
//

import SwiftData
import SwiftUI

@main
struct HotProspectsApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Prospect.self)
    }
}

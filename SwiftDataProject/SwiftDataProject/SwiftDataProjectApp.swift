//
//  SwiftDataProjectApp.swift
//  SwiftDataProject
//
//  Created by niccho on 12/11/2025.
//

import SwiftData
import SwiftUI

@main
struct SwiftDataProjectApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }.modelContainer(for: User.self)
    }
}

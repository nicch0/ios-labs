//
//  BookwormApp.swift
//  Bookworm
//
//  Created by niccho on 10/11/2025.
//

import SwiftData
import SwiftUI

@main
struct BookwormApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }.modelContainer(for: Book.self)
    }
}

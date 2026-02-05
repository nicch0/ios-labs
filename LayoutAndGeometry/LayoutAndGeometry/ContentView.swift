//
//  ContentView.swift
//  LayoutAndGeometry
//
//  Created by niccho on 2/12/2025.
//

import SwiftUI

// ContentView and background are layout neutral
// Shapes and colors are also layout neutrla

struct ContentView: View {
    var body: some View {
        Image(systemName: "flame")
            .frame(width: 200, height: 200)
            .border(.red)
    }
}

#Preview {
    ContentView()
}

//
//  ContentView.swift
//  SizingFatBobMan
//
//  Created by niccho on 13/11/2025.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Rectangle()
            .frame(width:400, height: 200)
            .foregroundStyle(.white)
            .border(.red)
    }
}

#Preview {
    ContentView()
}

//
//  ContentView.swift
//  LayoutAndIdentity
//
//  Created by niccho on 14/11/2025.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Text("Hello, world!")
                .border(.red)
                .frame(width: 300, height: 100, alignment: .bottomTrailing)
                .border(.green)
                .onTapGesture {
                    print(type(of: self.body))
                }
        }
    }
}

#Preview {
    ContentView()
}

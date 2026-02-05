//
//  ContentView.swift
//  LayingOutASimpleView
//
//  Created by niccho on 8/11/2025.
//

// https://developer.apple.com/documentation/swiftui/laying-out-a-simple-view

import SwiftUI

struct Message {
    let initials: String
    let content: String
}

struct ContentView: View {
    let message: Message = .init(initials: "NC", content: "I heard about this new place serving Japanese curries that i want to try out, are you ready for lunch?")

    var body: some View {
        HStack(alignment: .top) {
            ZStack {
                Circle()
                    .fill(Color.yellow)
                Text(message.initials)
            }
            .frame(width: 40, height: 40)
            Text(message.content)
        }
        .padding([.horizontal])
    }
}

#Preview {
    ContentView()
}

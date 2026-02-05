//
//  ContentView.swift
//  HomeJam
//
//  Created by niccho on 3/11/2025.
//

import SwiftUI

struct ContentView: View {
    @State private var rotationDegrees = 0.0
    
    private var animation: Animation {
        .linear
        .speed(0.2)
        .repeatForever(autoreverses: false)
    }
    
    var body: some View {
        VStack {
            ZStack{
//                Circle()
//                    .fill(
//                        RadialGradient(
//                            colors: [.yellow, .red],
//                            center: .top,
//                            startRadius: 0,
//                            endRadius: 200
//                        )
//                    )
//                    .frame(width: 300, height: 300)
                Circle()
                    .fill(.blue)
                    .frame(width: 300, height: 300)
                Color.clear
                    .overlay(Circle().fill(Color.black)
                        .frame(width:100, height:100))
                    .compositingGroup()
                    .luminanceToAlpha()
            }
            .rotationEffect(.degrees(rotationDegrees))
            .onAppear{
                withAnimation(animation) {
                    rotationDegrees = 360.0
                }
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}

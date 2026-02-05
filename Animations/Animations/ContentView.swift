//
//  ContentView.swift
//  Animations
//
//  Created by niccho on 2/11/2025.
//

//Create a button that when tapped:
//1. Scales a rectangle from 1.0 to 1.5
//2. Changes its color from blue to red
//3. Rotates it 360 degrees
//
//All three changes should animate together with a spring animation
//(duration: 1.0, bounce: 0.3). Use explicit animation.

import SwiftUI

struct CornerRotateModifier: ViewModifier {
    let amount: Double
    let anchor: UnitPoint
    
    func body(content: Content) -> some View {
        content
            .rotationEffect(.degrees(amount), anchor: anchor)
//            .clipped()
    }
}

extension AnyTransition {
    static var pivot: AnyTransition {
        .modifier(
            active: CornerRotateModifier(amount: -90, anchor: .topLeading),
            identity: CornerRotateModifier(amount: 0, anchor: .topLeading))
    }
}

struct ContentView: View {
    @State private var showRectangle = false
    
    var body: some View {
        ZStack{
            Rectangle()
                .fill(.blue)
                .frame(width: 200, height: 200)
            
            if showRectangle {
                Rectangle()
                    .fill(.red)
                    .frame(width: 200, height: 200)
                    .transition(.pivot)
            }
        }
        .onTapGesture {
            withAnimation{
                showRectangle.toggle()
            }
        }
    }
}

#Preview {
    ContentView()
}

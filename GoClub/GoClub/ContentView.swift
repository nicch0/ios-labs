//
//  ContentView.swift
//  GoClub
//
//  Created by niccho on 26/11/2025.
//

/**
 Objectives:
 - Understand how to manage colors in Asset Catalog
 - Learn how to create good gradients
 
 challenge 1 - buttons
 using a frosted white tint will still give a blue-ish hue from the background
 
 challenge 2 - consistent padding
 maxWidth the elements together before applying padding for consistency
 
 
 
 
 */

import SwiftUI

extension Color {
    // Brand colors - your app's personality
    static let brandPrimary = Color(#colorLiteral(red: 0.1937946677, green: 0.1308027804, blue: 1, alpha: 1)) // In asset catalog with light/dark variants
    static let brandAccent = Color(#colorLiteral(red: 0.9952229857, green: 1, blue: 0.02137495577, alpha: 1))
    static let brandAccentSecondary = Color(#colorLiteral(red: 0.4567014575, green: 0.9084452391, blue: 0.9670627713, alpha: 1))
    static let darkModeForeground = Color(#colorLiteral(red: 0.06274230033, green: 0.06274559349, blue: 0.1176368669, alpha: 1)) // In asset catalog with light/dark variants
}

struct ContentView: View {
    var body: some View {
        VStack {
            Text("every step counts")
                .font(.system(size: 90, weight: .bold, design: .monospaced))
                .lineHeight(.tight)
                .lineSpacing(-20)
                .tracking(-5)
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity, alignment: .leading)

            Spacer()
//
            Rectangle()
                .frame(width: 30, height: 300)
                .foregroundStyle(.red)
                .rotationEffect(Angle(degrees: 10))
                .offset(y: 130)

            VStack(spacing: 24.0) {
                Button(action: {}) {
                    Label("Sign in with Apple", systemImage: "apple.logo")
                        .font(.headline)
                        .foregroundStyle(.black)
                        .fontDesign(.monospaced)
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity, maxHeight: 60)
                }
                .glassEffect(
                    .regular.tint(.white).interactive()
                )

                Button(action: {}) {
                    Label("Sign in with Google", systemImage: "g.circle.fill")
                        .font(.headline)
                        .foregroundStyle(.black)
                        .fontDesign(.monospaced)
                        .fontWeight(.bold)
                        .tracking(-0.3)
                        .frame(maxWidth: .infinity, maxHeight: 60)
                }
                .glassEffect(
                    .regular.tint(.white).interactive()
                )
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(.horizontal, 48)
        .background(Color(#colorLiteral(red: 0.03346411511, green: 0.1276443899, blue: 0.7762205005, alpha: 1)))
    }
}

#Preview {
    ContentView()
}

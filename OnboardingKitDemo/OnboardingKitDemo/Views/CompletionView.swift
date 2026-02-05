//
//  CompletionView.swift
//  OnboardingKitDemo
//
//  Created by niccho on 28/11/2025.
//
import SwiftUI

struct CompletionView: View {
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "checkmark.circle.fill")
                .font(.system(size: 80))
                .foregroundStyle(.green)

            Text("You're All Set!")
                .font(.largeTitle)
                .fontWeight(.bold)

            Text("Ready to start your journey")
                .foregroundStyle(.secondary)
        }
    }
}

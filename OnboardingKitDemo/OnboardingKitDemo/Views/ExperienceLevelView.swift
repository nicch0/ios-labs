//
//  ExperienceLevelView.swift
//  OnboardingKitDemo
//
//  Created by niccho on 28/11/2025.
//

import SwiftUI

struct ExperienceLevelView: View {
    @Binding var selectedExperience: String?

    var body: some View {
        VStack(spacing: 20) {
            Text("What's your experience level?")
                .font(.title2)

            Button("Beginner") {
                selectedExperience = "beginner"
            }
            .buttonStyle(.bordered)

            Button("Expert") {
                selectedExperience = "expert"
            }
            .buttonStyle(.bordered)
        }
    }
}

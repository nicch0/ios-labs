//
//  GoalSelectionView.swift
//  OnboardingKitDemo
//
//  Created by niccho on 28/11/2025.
//

import SwiftUI

struct GoalSelectionView: View {
    let experience: String
    @Binding var selectedGoal: String?

    var body: some View {
        VStack(spacing: 20) {
            Text("What's your goal?")
                .font(.title2)

            Text("As a \(experience), we recommend:")
                .foregroundStyle(.secondary)

            // Different goals based on experience
            if experience == "beginner" {
                Button("Learn the Basics") {
                    selectedGoal = "basics"
                }
                .buttonStyle(.bordered)

                Button("Build My First App") {
                    selectedGoal = "first_app"
                }
                .buttonStyle(.bordered)
            } else {
                Button("Master Advanced Topics") {
                    selectedGoal = "advanced"
                }
                .buttonStyle(.bordered)

                Button("Build Production Apps") {
                    selectedGoal = "production"
                }
                .buttonStyle(.bordered)
            }
        }
    }
}

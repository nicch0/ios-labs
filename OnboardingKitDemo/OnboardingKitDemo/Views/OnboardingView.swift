//
//  OnboardingView.swift
//  OnboardingKitDemo
//
//  Created by niccho on 28/11/2025.
//

import OnboardingKit
import SwiftUI

protocol OnboardingViewProtocol {
    var flow: OnboardingFlowManager { get }
}

struct OnboardingView: View {
    @State private var flow = OnboardingFlow(initialStep: .welcome)
    @State private var selectedExperience: String?
    @State private var selectedGoal: String?

    var body: some View {
        OnboardingFrameView(
            progress: flow.currentStep.progress,
            showBackButton: true,
            onBack: { flow.back() },
            onContinue: handleContinue
        ) {
            contentForCurrentStep
        }
    }

    private func handleContinue() {
        switch flow.currentStep {
        case .welcome:
            flow.push(.experienceLevel)
        case .experienceLevel:
            if let experience = selectedExperience {
                flow.push(.goal(experience: experience))
            }
        case .goal:
            if selectedGoal != nil {
                flow.push(.completion)
            }
        case .completion:
            flow.complete()
        }
    }

    @ViewBuilder
    private var contentForCurrentStep: some View {
        switch flow.currentStep {
        case .welcome:
            WelcomeStepView()
        case .experienceLevel:
            ExperienceLevelView(selectedExperience: $selectedExperience)
        case let .goal(experience):
            GoalSelectionView(experience: experience, selectedGoal: $selectedGoal)
        case .completion:
            CompletionView()
        }
    }
}

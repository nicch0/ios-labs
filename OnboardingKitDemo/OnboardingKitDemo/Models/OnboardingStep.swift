//
//  OnboardingStep.swift
//  OnboardingKitDemo
//
//  Created by niccho on 28/11/2025.
//
import OnboardingKit

enum OnboardingStep: OnboardingStepProtocol {
    case welcome
    case experienceLevel
    case goal(experience: String)
    case completion

    var progress: Double {
        switch self {
        case .welcome: return 10
        case .experienceLevel: return 20
        case .goal: return 40
        case .completion: return 90
        }
    }
}

typealias OnboardingFlow = OnboardingFlowManager<OnboardingStep>

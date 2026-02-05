//
//  SoraBounceView.swift
//  PhaseAnimations
//
//  Created by niccho on 1/12/2025.
//  https://mobbin.com/screens/c53c992c-b51a-4ad4-8889-b331b487758a
//  TODO: Add GeoReader for %-based movement

import SwiftUI

private struct SoraAnimationValues {
    var horizontalPosition = 100.0
    var verticalPosition = 250.0
}

struct SoraBounceView: View {
    var body: some View {
        Text("☁")
            .font(.system(size: 64))
            .keyframeAnimator(initialValue: SoraAnimationValues(), repeating: true) { content, value in
                content
                    .position(x: value.horizontalPosition, y: value.verticalPosition)
            } keyframes: { _ in
                KeyframeTrack(\.horizontalPosition) {
                    SpringKeyframe(120, duration: 0.08)
                    SpringKeyframe(140, duration: 0.08)
                    SpringKeyframe(160, duration: 0.08)
                    SpringKeyframe(180, duration: 0.08)
                    SpringKeyframe(200, duration: 0.08)
                    LinearKeyframe(200, duration: 0.5) // pause at center

                    SpringKeyframe(220, duration: 0.08)
                    SpringKeyframe(240, duration: 0.08)
                    SpringKeyframe(260, duration: 0.08)
                    SpringKeyframe(280, duration: 0.08)
                    SpringKeyframe(300, duration: 0.08)
                    LinearKeyframe(300, duration: 0.5) // pause at right

                    SpringKeyframe(280, duration: 0.08)
                    SpringKeyframe(260, duration: 0.08)
                    SpringKeyframe(240, duration: 0.08)
                    SpringKeyframe(220, duration: 0.08)
                    SpringKeyframe(200, duration: 0.08)
                    LinearKeyframe(200, duration: 0.5) // pause at center

                    SpringKeyframe(180, duration: 0.08)
                    SpringKeyframe(160, duration: 0.08)
                    SpringKeyframe(140, duration: 0.08)
                    SpringKeyframe(120, duration: 0.08)
                    SpringKeyframe(100, duration: 0.08)
                    LinearKeyframe(100, duration: 0.5) // pause at left
                }

                KeyframeTrack(\.verticalPosition) {
                    // Rise: 100 → 200 (delayed then fast)
                    SpringKeyframe(252, duration: 0.08)
                    SpringKeyframe(266, duration: 0.08)
                    SpringKeyframe(304, duration: 0.08)
                    SpringKeyframe(378, duration: 0.08)
                    SpringKeyframe(500, duration: 0.08)
                    LinearKeyframe(500, duration: 0.5) // pause at peak

                    // Descend: 200 → 300 (mirror - fast then delayed)
                    SpringKeyframe(378, duration: 0.08)
                    SpringKeyframe(304, duration: 0.08)
                    SpringKeyframe(266, duration: 0.08)
                    SpringKeyframe(252, duration: 0.08)
                    SpringKeyframe(250, duration: 0.08)
                    LinearKeyframe(250, duration: 0.5) // pause at bottom

                    // Rise: 300 → 200 (delayed then fast)
                    SpringKeyframe(252, duration: 0.08)
                    SpringKeyframe(266, duration: 0.08)
                    SpringKeyframe(304, duration: 0.08)
                    SpringKeyframe(378, duration: 0.08)
                    SpringKeyframe(500, duration: 0.08)
                    LinearKeyframe(500, duration: 0.5) // pause at peak

                    // Descend: 200 → 100 (fast then delayed)
                    SpringKeyframe(378, duration: 0.08)
                    SpringKeyframe(304, duration: 0.08)
                    SpringKeyframe(266, duration: 0.08)
                    SpringKeyframe(252, duration: 0.08)
                    SpringKeyframe(250, duration: 0.08)
                    LinearKeyframe(250, duration: 0.5) // pause at bottom
                }
            }
    }
}

#Preview {
    SoraBounceView()
}

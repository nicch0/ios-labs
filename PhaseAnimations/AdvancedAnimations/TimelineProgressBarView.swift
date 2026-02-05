//
//  ProgressBarView.swift
//  PhaseAnimations
//
//  Created by niccho on 1/12/2025.
//

import SwiftUI

struct TimelineProgressBarView: View {
    private struct ProgressKeyframes {
        var progress: Double = 0.0
    }

    @State private var animationTrigger = false

    // this state var is only for the label, changed during TimelineView
    @State private var progress: Double = 0.0
    @State private var animationStartTime = Date()

    private var progressTimeline: KeyframeTimeline<ProgressKeyframes> {
        KeyframeTimeline(initialValue: ProgressKeyframes()) {
            KeyframeTrack(\.progress) {
                CubicKeyframe(0.8, duration: 2.0)
                CubicKeyframe(1.0, duration: 3.0)
            }
        }
    }

    private var progressPercentageLabel: some View {
        Text("\(Int(progress * 100))%")
            .font(.system(size: 86))
            .fontWeight(.bold)
    }

    private var progressBar: some View {
        TimelineView(.animation) { context in
            let elapsedTime = animationTrigger ? context.date.timeIntervalSince(animationStartTime) : 0

            let keyframeValue = progressTimeline.value(time: elapsedTime)

            let hue = keyframeValue.progress * 120

            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 30)
                    .fill(.gray)
                    .opacity(0.3)
                    .frame(width: 350, height: 10)

                RoundedRectangle(cornerRadius: 30)
                    .fill(
                        LinearGradient(
                            colors: [
                                Color(hue: 0.0, saturation: 0.8, brightness: 0.8),
                                Color(hue: hue / 360, saturation: 0.8, brightness: 0.8),
                                Color(hue: hue / 360, saturation: 0.9, brightness: 0.9),
                            ],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .frame(width: 350 * keyframeValue.progress, height: 10)
            }
            .onChange(of: keyframeValue.progress) { _, newValue in
                // change the progress for the label
                progress = newValue
            }
        }
    }

    private var resetButton: some View {
        Button {
            animationTrigger = false
            progress = 0.0

            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                animationStartTime = Date()
                animationTrigger = true
            }
        } label: {
            Label("Reset", systemImage: "arrow.trianglehead.clockwise.rotate.90")
                .foregroundStyle(.white)
        }
        .frame(width: 300)
        .tint(.black)
        .buttonStyle(.borderedProminent)
    }

    var body: some View {
        Spacer()
        VStack(spacing: 36) {
            progressPercentageLabel

            Text("We're setting everything up for you")
                .font(.largeTitle.bold())

            progressBar
        }
        .multilineTextAlignment(.center)
        .fontDesign(.rounded)
        .padding(.horizontal)
        .onAppear {
            animationTrigger = true
            animationStartTime = Date()
        }

        Spacer()

        resetButton

        Spacer()
    }
}

#Preview {
    TimelineProgressBarView()
}

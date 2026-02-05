//
//  ChooseLoveView.swift
//  PhaseAnimations
//
//  Created by niccho on 29/11/2025.
//

import SwiftUI

private enum AnimationPhase: CaseIterable {
    case initial
    case move
    case scale

    var verticalOffset: Double {
        switch self {
        case .initial:
            0
        case .move, .scale: -64
        }
    }

    var scaleAmount: Double {
        switch self {
        case .initial:
            1
        case .scale, .move:
            2.0
        }
    }

    var animation: Animation {
        switch self {
        case .initial: .easeIn(duration: 0.6).delay(0.7)
        case .move: .easeOut(duration: 0.2)
        case .scale: .spring(duration: 0.3, bounce: 0.7)
        }
    }
}

enum KissingAnimationPhase: CaseIterable {
    case initial
    case move

    var horizontalOffset: Double {
        switch self {
        case .initial:
            -400
        case .move:
            -170
        }
    }

    var animation: Animation {
        switch self {
        case .initial:
            .easeIn(duration: 0.6).delay(0.7)
        case .move:
            .easeInOut(duration: 0.2)
        }
    }
}

enum ReverseKissingAnimationPhase: CaseIterable {
    case initial
    case move

    var horizontalOffset: Double {
        switch self {
        case .initial:
            400
        case .move:
            170
        }
    }

    var animation: Animation {
        switch self {
        case .initial:
            .easeIn(duration: 0.6).delay(0.7)
        case .move:
            .easeInOut(duration: 0.2)
        }
    }
}

struct ChooseLoveView: View {
    @State private var offset: CGFloat
    @State private var scale: CGFloat
    @State private var likeCount: Int

    init() {
        offset = CGFloat(0)
        scale = 16.0
        likeCount = 1
    }

    var body: some View {
        VStack {
            Spacer()
            ZStack {
                Text("😘")
                    .font(.system(size: 64))
                    .rotationEffect(Angle(degrees: -15))
                    .offset(x: 0)
                    .phaseAnimator(KissingAnimationPhase.allCases, trigger: likeCount) { content, phase in
                        content.offset(x: phase.horizontalOffset)
                    } animation: { $0.animation }

                Text("😘")
                    .font(.system(size: 64))
                    .rotationEffect(Angle(degrees: -15))
                    .scaleEffect(x: -1)
                    .offset(x: 0)
                    .phaseAnimator(ReverseKissingAnimationPhase.allCases, trigger: likeCount) { content, phase in
                        content.offset(x: phase.horizontalOffset)
                    } animation: { $0.animation }
            }
            Spacer().frame(height: 200)

            Text("💖")
                .font(.system(size: 64))
                .phaseAnimator(AnimationPhase.allCases, trigger: likeCount) { content, phase in
                    content
                        .offset(y: phase.verticalOffset)
                        .scaleEffect(phase.scaleAmount)
                } animation: { phase in phase.animation }
                .onTapGesture {
                    likeCount += 1
                }

            Spacer()
            Spacer()
        }
    }
}

#Preview {
    ChooseLoveView()
}

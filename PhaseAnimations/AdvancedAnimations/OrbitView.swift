//
//  OrbitView.swift
//  PhaseAnimations
//
//  Created by niccho on 29/11/2025.
//
import SwiftUI

enum OrbitPhaseAnimation: CaseIterable {
    case initial
    case scale
    case rotate

    var scaleAmount: CGFloat {
        switch self {
        case .initial:
            1.0
        case .scale, .rotate:
            1.5
        }
    }

    var verticalOffset: CGFloat {
        switch self {
        case .initial:
            0.0
        case .scale, .rotate:
            -100
        }
    }

    var animation: Animation {
        switch self {
        case .initial:
            .snappy
        case .scale, .rotate:
            .easeOut(duration: 0.2)
        }
    }
}

struct OrbitView: View {
    let angleFrame: CGFloat = 30.0
    let angleXOffset: CGFloat = 38
    let angleYOffset: CGFloat = 31

    @State var offset: CGPoint = .init(x: 0, y: 0)

    @State private var buttonCount = 0

    var topLeftAngle: some View {
        Image("angles")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .scaleEffect(x: -1)
            .offset(x: -angleXOffset, y: -angleYOffset)
            .frame(width: angleFrame)
    }

    var topRightAngle: some View {
        Image("angles")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .offset(x: angleXOffset, y: -angleYOffset)
            .frame(width: angleFrame)
    }

    var bottomLeftAngle: some View {
        Image("angles")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .scaleEffect(x: -1, y: -1)
            .offset(x: -angleXOffset, y: angleYOffset)
            .frame(width: angleFrame)
    }

    var bottomRightAngle: some View {
        Image("angles")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .scaleEffect(y: -1)
            .offset(x: angleXOffset, y: angleYOffset)
            .frame(width: angleFrame)
    }

    var o: some View {
        Image("o")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 100)
    }

    var body: some View {
        Spacer()
        ZStack {
            o
            topLeftAngle
            topRightAngle
            bottomLeftAngle
            bottomRightAngle
        }
        .phaseAnimator(
            OrbitPhaseAnimation.allCases,
            trigger: buttonCount
        ) { content, phase in
            content
                .scaleEffect(phase.scaleAmount)
                .offset(y: phase.verticalOffset)

        } animation: { phase in
            phase.animation
        }
        .onTapGesture {
            buttonCount += 1
        }

        HStack {
            Circle()
                .frame(width: 20, height: 20)
            Circle()
                .frame(width: 20, height: 20)
            Circle()
                .frame(width: 20, height: 20)
        }

        VStack {
            Circle()
                .frame(width: 20, height: 20)
            Circle()
                .frame(width: 20, height: 20)
            Circle()
                .frame(width: 20, height: 20)
        }

        Circle()
            .frame(width: 100, height: 100)
            .offset(x: offset.x, y: offset.y)
            .gesture(
                DragGesture()
                    .onChanged { dragVal in
                        offset.x = dragVal.translation.width
                        offset.y = dragVal.translation.height
                    }
                    .onEnded { _ in
                        offset.x = 0
                        offset.y = 0
                    }
            )

        Spacer()
    }
}

#Preview {
    OrbitView()
}

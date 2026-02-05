//
//  ShinyStartButton.swift
//  PhaseAnimations
//
//  Created by niccho on 1/12/2025.
//  https://mobbin.com/screens/a458260c-2ee5-4ccc-baef-1ce839868226
//

import SwiftUI

struct ThreeDimensional: ButtonStyle {
    private struct ThreeDimensionalKeyframes {
        var offset: CGFloat = -150
    }

    func makeBody(configuration: Configuration) -> some View {
        let buttonColor = Color(red: 1, green: 0.54, blue: 0.77)

        let offset: CGFloat = 4
        let cornerRadius: CGFloat = 30

        return ZStack {
            RoundedRectangle(cornerRadius: cornerRadius)
                .foregroundStyle(buttonColor.mix(with: .black, by: 0.3))
                .offset(y: offset)

            RoundedRectangle(cornerRadius: cornerRadius)
                .foregroundStyle(buttonColor)
                .offset(y: configuration.isPressed ? offset : 0)
                .overlay {
                    HStack(spacing: 10) {
                        Rectangle()
                            .foregroundStyle(.white)
                            .frame(width: 30, height: 100)
                            .rotationEffect(Angle(degrees: 30))
                            .opacity(0.3)

                        Rectangle()
                            .foregroundStyle(.white)
                            .frame(width: 10, height: 100)
                            .rotationEffect(Angle(degrees: 30))
                            .opacity(0.3)
                    }
                    .keyframeAnimator(
                        initialValue: ThreeDimensionalKeyframes(),
                        repeating: true
                    ) { content, value in
                        content.offset(x: value.offset)
                    } keyframes: { _ in
                        KeyframeTrack(\.offset) {
                            CubicKeyframe(200, duration: 2.5)
                            LinearKeyframe(200, duration: 2.0)
                        }
                    }
                    .frame(width: 300, height: 60)
                    .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
                }
                .overlay {
                    Text("Start")
                        .font(.system(size: 16, weight: .bold, design: .rounded))
                        .foregroundStyle(.white)
                        .offset(y: configuration.isPressed ? offset : 0)
                }
        }
        .frame(width: 300, height: 60)
        .compositingGroup()
        .shadow(radius: 6, y: 4)
    }
}

struct ShinyStartView: View {
    var body: some View {
        Button(action: {}) {}
            .buttonStyle(ThreeDimensional())
    }
}

#Preview {
    ShinyStartView()
}

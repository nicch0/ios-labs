//
//  CardView.swift
//  Flashzilla
//
//  Created by niccho on 27/11/2025.
//

import SwiftUI

struct CardView: View {
    @State private var isAnswerVisible = false
    @State private var offset = CGSize.zero
    @Environment(\.accessibilityDifferentiateWithoutColor) var differentiateWithoutColor

    var cardDrag: Double {
        offset.width * 5
    }

    var cardOpacity: Double {
        2 - Double(abs(offset.width / 50.0))
    }

    var card: Card

    var removal: (() -> Void)? = nil

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25)
                .fill(
                    differentiateWithoutColor
                        ? .white
                        : .white
                        .opacity(1 - Double(abs(offset.width / 50)))
                )
                .background(
                    differentiateWithoutColor
                        ? nil
                        : RoundedRectangle(cornerRadius: 25)
                        .fill(offset.width > 0 ? .green : .red)
                )
                .shadow(radius: 10)

            VStack {
                Text(card.prompt)
                    .font(.largeTitle)
                    .foregroundStyle(.black)

                if isAnswerVisible {
                    Divider()

                    Text(card.answer)
                        .font(.title)
                        .foregroundStyle(.secondary)
                }
            }
            .padding(20)
            .multilineTextAlignment(.center)
        }
        .frame(width: 450, height: 250)
        .rotationEffect(.degrees(offset.width / 5.0))
        .offset(x: cardDrag)
        .opacity(cardOpacity)
        .gesture(
            DragGesture()
                .onChanged { value in
                    offset = value.translation
                }
                .onEnded { _ in
                    if abs(offset.width) > 100 {
                        removal?()
                    } else {
                        offset = .zero
                    }
                }
        )
        .onTapGesture {
            withAnimation(.snappy(duration: 0.1)) {
                isAnswerVisible.toggle()
            }
        }
        .accessibilityAddTraits(.isButton)
        .animation(.bouncy, value: offset)
    }
}

#Preview {
    VStack {
        CardView(card: .example)
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
}

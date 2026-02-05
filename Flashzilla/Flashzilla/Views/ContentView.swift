//
//  ContentView.swift
//  Flashzilla
//
//  Created by niccho on 27/11/2025.
//

import SwiftUI
internal import Combine

extension View {
    func stacked(at position: Int, in total: Int) -> some View {
        let offset = Double(total - position)
        return self.offset(y: offset * 10)
    }
}

struct ContentView: View {
    @Environment(\.accessibilityDifferentiateWithoutColor) var differentiateWithoutColor

    @Environment(\.scenePhase) var scenePhase

    @State private var cards = [Card](repeating: Card.example, count: 10)

    // Rotation and drag
    @State private var offset = CGSize.zero

    @State private var timeRemaining = 100
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    var gameOver: Bool {
        cards.isEmpty
    }

    var body: some View {
        ZStack {
            VStack {
                Text("Time: \(timeRemaining)")
                    .font(.largeTitle)
                    .foregroundStyle(.white)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 5)
                    .background(.black.opacity(0.75))
                    .clipShape(.capsule)

                ZStack {
                    ForEach(0 ..< cards.count, id: \.self) { idx in
                        CardView(card: cards[idx]) {
                            withAnimation {
                                removeCard(at: idx)
                            }
                        }
                        .stacked(at: idx, in: cards.count)
                        .allowsHitTesting(idx == cards.count - 1)
                        .accessibilityHidden(idx < cards.count - 1)
                    }
                }
                .allowsHitTesting(timeRemaining > 0)

                if gameOver {
                    Spacer().frame(height: 20)
                    Button("Start Over") {
                        resetGame()
                    }
                    .font(.largeTitle)
                    .foregroundStyle(.white)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 5)
                    .background(.black.opacity(0.75))
                    .clipShape(.capsule)
                }
            }
            if differentiateWithoutColor {
                VStack {
                    Spacer()

                    HStack {
                        Image(systemName: "xmark.circle")
                            .padding()
                            .background(.black.opacity(0.7))
                            .clipShape(.circle)
                        Spacer()
                        Image(systemName: "checkmark.circle")
                            .padding()
                            .background(.black.opacity(0.7))
                            .clipShape(.circle)
                    }
                    .foregroundStyle(.white)
                    .font(.largeTitle)
                    .padding()
                }
            }
        }
        .onReceive(timer) { _ in
            guard !gameOver else { return }
            guard scenePhase == .active else { return }

            if timeRemaining > 0 {
                timeRemaining -= 1
            }
        }
    }

    func resetGame() {
        timeRemaining = 100
        cards = [Card](repeating: Card.example, count: 10)
    }

    func removeCard(at idx: Int) {
        cards.remove(at: idx)
    }
}

#Preview {
    ContentView()
}

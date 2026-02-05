//
//  ProgressBarView.swift
//  PhaseAnimations
//
//  Created by niccho on 1/12/2025.
//

import SwiftUI

private struct ProgressKeyframes {
    var width: Double = 0.0
}

struct BasicProgressBarView: View {
    @State private var progress: Double = 0

    var body: some View {
        Spacer()
        VStack(spacing: 36) {
            // THIS DOESNT WORK!
//            Text("\(progress.formatted(.percent))")
//                .font(.system(size: 86))
//                .fontWeight(.bold)
//                .contentTransition(.numericText(value: progress))
//
            Text("We're setting everything up for you")
                .font(.largeTitle.bold())

            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 30)
                    .fill(.gray)
                    .opacity(0.3)
                    .frame(width: 350, height: 10)

                RoundedRectangle(cornerRadius: 30)
                    .fill(.blue.gradient)
                    .frame(width: 350 * progress, height: 10)
            }
        }
        .multilineTextAlignment(.center)
        .fontDesign(.rounded)
        .padding(.horizontal)

        Spacer()

        Button {
            reset()
        } label: {
            Label("Reset", systemImage: "arrow.trianglehead.clockwise.rotate.90")
                .foregroundStyle(.white)
        }
        .frame(width: 300)
        .tint(.black)
        .buttonStyle(.borderedProminent)

        Spacer()
    }

    func reset() {
        print("Resetting")
        progress = 0.0

        withAnimation(.easeOut(duration: 2.0)) {
            progress = 0.9
        } completion: {
            withAnimation(.linear(duration: 3.0)) {
                progress = 1.0
            }
        }
    }
}

#Preview {
    BasicProgressBarView()
}

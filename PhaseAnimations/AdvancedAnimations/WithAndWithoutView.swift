//
//  WithAndWithoutView.swift
//  PhaseAnimations
//
//  Created by niccho on 1/12/2025.
//

import SwiftUI

struct WithAndWithoutView: View {
    @State private var bar1Height: CGFloat = 0
    @State private var bar2Height: CGFloat = 0
    @State private var showBar1Text = false
    @State private var showBar2Text = false
    @State private var showBottomText = false

    var body: some View {
        VStack {
            VStack {
                HStack(spacing: 24) {
                    ZStack(alignment: .bottom) {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(.white)
                            .frame(height: 300)
                            .overlay(alignment: .top) {
                                Text("Without\nCal AI")
                                    .fontWeight(.bold)
                                    .multilineTextAlignment(.center)
                                    .padding(.vertical)
                            }

                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color(#colorLiteral(red: 0.8940430284, green: 0.8940429688, blue: 0.8940429688, alpha: 1)))
                            .frame(height: bar1Height)
                            .overlay(alignment: .bottom) {
                                if showBar1Text {
                                    Text("20%")
                                        .fontWeight(.bold)
                                        .padding()
                                }
                            }
                    }

                    ZStack(alignment: .bottom) {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(.white)
                            .frame(height: 300)
                            .overlay(alignment: .top) {
                                Text("With\nCal AI")
                                    .fontWeight(.bold)
                                    .multilineTextAlignment(.center)
                                    .padding(.vertical)
                            }

                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color(#colorLiteral(red: 0.1249234304, green: 0.09621296078, blue: 0.1489576399, alpha: 1)))
                            .frame(height: bar2Height)
                            .overlay(alignment: .bottom) {
                                if showBar2Text {
                                    Text("2X")
                                        .fontWeight(.bold)
                                        .foregroundStyle(.white)
                                        .padding()
                                        .transition(.opacity)
                                }
                            }
                    }
                }

                Text("Cal AI makes it easy and holds you accountable")
                    .multilineTextAlignment(.center)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .opacity(showBottomText ? 1 : 0)
                    .padding(.vertical)
            }
            .padding(.horizontal, 60)
            .frame(width: 400, height: 400)
            .background(Color(#colorLiteral(red: 0.9447143674, green: 0.9589650035, blue: 0.9560338855, alpha: 1)))
            .clipShape(RoundedRectangle(cornerRadius: 40))
            .onAppear {
                reset()
            }
            Spacer()
                .frame(height: 50)

            Button {
                reset()
            } label: {
                Label("Reset", systemImage: "arrow.trianglehead.clockwise.rotate.90")
                    .foregroundStyle(.white)
            }
            .frame(width: 300)
            .tint(.black)
            .buttonStyle(.borderedProminent)
        }
    }

    func reset() {
        bar1Height = 0
        bar2Height = 0
        showBar1Text = false
        showBar2Text = false
        showBottomText = false

        withAnimation(.easeOut(duration: 0.7)) {
            bar1Height = 60
        }

        withAnimation(.easeOut(duration: 0.9)) {
            bar2Height = 200
        }

        withAnimation(.spring.delay(0.7)) {
            showBar1Text = true
        }

        withAnimation(.spring.delay(0.9)) {
            showBar2Text = true
        }

        withAnimation(.spring.delay(1.0)) {
            showBottomText = true
        }
    }
}

#Preview {
    WithAndWithoutView()
}

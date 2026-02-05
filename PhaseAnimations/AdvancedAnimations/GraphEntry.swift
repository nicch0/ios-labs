//
//  GraphEntry.swift
//  PhaseAnimations
//
//  Created by niccho on 1/12/2025.
//

import SwiftUI

struct Line: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: rect.width, y: 0))
        return path
    }
}

struct CalAICurve: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()

        let startX = rect.minX + 0
        let startY = rect.minY + 50
        let endX = rect.maxX
        let endY = rect.maxY - 50

        let rangeX = endX - startX
        let rangeY = endY - startY

        path.move(to: CGPoint(x: startX, y: startY))

        path.addCurve(
            to: CGPoint(x: endX, y: endY),
            control1: CGPoint(x: rangeX * 0.8, y: rangeY * 0.3),
            control2: CGPoint(x: rangeX * 0.2, y: rangeY * 0.9)
        )

        return path
    }
}

struct TraditionalDietCurve: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()

        let startX = rect.minX
        let startY = rect.minY + 50
        let endX = rect.maxX
        let endY = rect.minY

        let rangeX = endX - startX

        path.move(to: CGPoint(x: startX, y: startY))

        path.addCurve(
            to: CGPoint(x: endX, y: endY),
            control1: CGPoint(x: rangeX * 0.7, y: rect.maxY * 0.9 + 60),
            control2: CGPoint(x: rangeX * 0.6, y: rect.minY * 1.0)
        )

        return path
    }
}

struct GraphEntryView: View {
    @State private var traditionalDietCurveProgress: CGFloat = 0
    @State private var calaiDietCurveProgress: CGFloat = 0
    @State private var bottomXAxisProgress: CGFloat = 0

    var dashedLine: some View {
        Line()
            .stroke(style: StrokeStyle(lineWidth: 1, dash: [5]))
            .frame(height: 1)
    }

    var solidLine: some View {
        Line()
            .trim(from: 0.0, to: bottomXAxisProgress)
            .stroke(style: StrokeStyle(lineWidth: 1, lineCap: .butt))
            .frame(height: 1)
    }

    var circle: some View {
        Circle()
            .fill(.white)
            .stroke(.black, style: StrokeStyle(lineWidth: 3))
            .frame(width: 16, height: 16)
    }

    var body: some View {
        VStack {
            Spacer()

            RoundedRectangle(cornerRadius: 20)
                .fill(Color(#colorLiteral(red: 0.9760742784, green: 0.9760741591, blue: 0.9760741591, alpha: 1)))
                .frame(height: 300)
                .overlay {
                    GeometryReader { geo in
                        let frame = geo.frame(in: .local)
                        ZStack {
                            dashedLine
                                .offset(y: -100)

                            dashedLine

                            solidLine
                                .offset(y: 100)

                            TraditionalDietCurve()
                                .trim(from: 0.0, to: traditionalDietCurveProgress)
                                .stroke(.red, style: StrokeStyle(
                                    lineWidth: 3,
                                    lineCap: .square
                                ))

                            CalAICurve()
                                .trim(from: 0.0, to: calaiDietCurveProgress)
                                .stroke(Color.black, lineWidth: 3)

                            circle
                                .position(x: frame.minX, y: frame.minY + 50)

                            circle
                                .position(x: frame.maxX, y: frame.maxY - 50)
                        }
                    }
                }
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
        .onAppear {
            reset()
        }
    }

    func reset() {
        bottomXAxisProgress = 0
        calaiDietCurveProgress = 0
        traditionalDietCurveProgress = 0

        withAnimation(.linear(duration: 0.5)) {
            bottomXAxisProgress = 1
        }
        withAnimation(.easeOut(duration: 1.0).delay(0.3)) {
            calaiDietCurveProgress = 1
            traditionalDietCurveProgress = 1
        }
    }
}

#Preview {
    GraphEntryView()
}

//
//  FrontBackCardView.swift
//  PhaseAnimations
//
//  Created by niccho on 2/12/2025.
//

import SwiftUI

struct FrontBackCardView: View {
    @State private var rotationAngle = Angle(degrees: 0)
    @State private var showingFrontSide = true

    var frontView: some View {
        RoundedRectangle(cornerRadius: 30)
            .fill(.blue)
            .gesture(
                DragGesture()
                    .onChanged { gesture in
                        rotationAngle.degrees += gesture.translation.width / 50
                    }
                    .onEnded { gesture in
                        rotationAngle.degrees += gesture.translation.width / 50
                    }
            )
    }

    var backView: some View {
        RoundedRectangle(cornerRadius: 30)
            .fill(.red)
    }

    var body: some View {
        Group {
            if rotationAngle.degrees < 90 {
                frontView
            } else {
                backView
            }
        }
        .rotation3DEffect(rotationAngle, axis: (x: 0, y: 1, z: 0))
    }
}

#Preview {
    FrontBackCardView()
}

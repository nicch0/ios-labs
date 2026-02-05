//
//  MatchedGeometryView.swift
//  PhaseAnimations
//
//  Created by niccho on 2/12/2025.
//

import SwiftUI

struct FlippedCirclesView: View {
    @Namespace private var animation
    @State private var isFlipped = false
    var body: some View {
        VStack {
            if isFlipped {
                Circle()
                    .fill(.red)
                    .frame(width: 44, height: 44)
                    .matchedGeometryEffect(id: "Shape", in: animation)

                Text("Taylor Swift – 1989")
                    .font(.headline)
                    .matchedGeometryEffect(id: "AlbumTitle", in: animation)
            } else {
                Text("Taylor Swift – 1989")
                    .font(.headline)
                    .matchedGeometryEffect(id: "AlbumTitle", in: animation)
                Circle()
                    .fill(.blue)
                    .frame(width: 44, height: 44)
                    .matchedGeometryEffect(id: "Shape", in: animation)
            }
        }
        .onTapGesture {
            withAnimation {
                isFlipped.toggle()
            }
        }
    }
}

#Preview {
    FlippedCirclesView()
}

//
//  OpenView.swift
//  LayoutAndGeometry
//
//  Created by niccho on 2/12/2025.
//

import SwiftUI

struct OpenView: View {
    @State private var selectedItem: String?
    @Namespace private var animation
    let emotions = ["Eager", "Excited", "Cheerful", "Awe", "Determined"]
    let animationDuration: Double = 4.0

    var body: some View {
        VStack {
            ForEach(emotions, id: \.self) { emotion in
                if selectedItem != emotion {
                    Circle()
                        .fill(.orange)
                        .frame(width: 100, height: 100)
                        .overlay {
                            Text(emotion)
                                .foregroundStyle(.white)
                        }
                        .matchedGeometryEffect(id: emotion, in: animation, anchor: .bottom)
                        .onTapGesture {
                            withAnimation(.spring(duration: animationDuration)) {
                                selectedItem = emotion
                            }
                        }
                }
            }

            if let selectedItem {
                Circle()
                    .fill(.orange)
                    .matchedGeometryEffect(id: selectedItem, in: animation)
                    .frame(width: 300, height: 300)
                    .onTapGesture {
                        withAnimation(.spring(duration: animationDuration)) {
                            self.selectedItem = nil
                        }
                    }
            }
        }
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    OpenView()
}

//
//  Carousel.swift
//  PlacesPlusFaces
//
//  Created by niccho on 26/11/2025.
//
import SwiftUI

struct ItemView: View {
    let text: String
    var body: some View {
        Text(text)
            .fontWeight(.semibold)
            .font(.system(size: 52).italic(true))
            .fontDesign(.default)
            .tracking(-3)
            .scrollTargetLayout()
            .lineLimit(1)
    }
}

struct CarouselView: View {
    let count = 10
    var text: String
    var titleCarousel: [String]

    @State private var offset: CGFloat = 0

    @State private var isAutoScrolling = true

    // Distance the elements will scroll per update (higher = faster)
    let autoScrollOffsetAmount = 0.8

    init(text: String) {
        self.text = text
        titleCarousel = Array(repeating: text, count: count)
    }

    var body: some View {
        TimelineView(.animation) { timeline in
            ScrollView(.horizontal) {
                LazyHStack(alignment: .center, spacing: 0) {
                    ForEach(0 ..< 1000) { idx in
                        ItemView(text: text)
                            .padding(.horizontal)
                            .id(idx)
                    }
                }
                .offset(x: -offset)
            }
            .scrollIndicators(.hidden)
            .onChange(of: timeline.date) { _, _ in
                if isAutoScrolling {
                    offset += autoScrollOffsetAmount
                }
            }
        }
        .gesture(
            DragGesture()
                .onChanged { _ in
                    isAutoScrolling = false
                }
                .onEnded { _ in
                    isAutoScrolling = true
                }
        )
        .fixedSize(horizontal: false, vertical: true)

    }
}

#Preview {
    CarouselView(text: "Places + Faces")
}

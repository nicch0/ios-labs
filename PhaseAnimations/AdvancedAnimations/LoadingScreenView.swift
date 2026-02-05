////
////  LoadingScreenView.swift
////  PhaseAnimations
////
////  Created by niccho on 1/12/2025.
////
//
//import SwiftUI
//
//private struct LoadingKeyframes {
//    var progress: Double = 0.0
//}
//
//struct LoadingScreenView: View {
//    @State private var animationTrigger = false
//    @State private var currentProgress: Double = 0.0
//    @State private var animationStartTime: Date = .init()
//
//    private var progressTimeline: KeyframeTimeline<LoadingKeyframes> {
//        KeyframeTimeline(initialValue: LoadingKeyframes()) {
//            KeyframeTrack(\.progress) {
//                CubicKeyframe(0.8, duration: 2.0)
//                LinearKeyframe(1.0, duration: 3.0)
//            }
//        }
//    }
//
//    private var progressBar: some View {
//        TimelineView(.animation) { _ in
//            let elapsedTime = animationTrigger ? content.date.timeIntervalSince(animationStartTime) : 0
//
//            let keyframeValue = progressTimeline.value(time: elapsedTime)
//
//            ZStack(alignment: .leading) {
//                RoundedRectangle(cornerRadius: 30)
//                    .fill(.gray)
//                    .frame(width: 400, height: 40)
//
//                RoundedRectangle(cornerRadius: 30)
//                    .fill(.blue.gradient)
//                    .frame(width: keyframeValue.progress / 100 * 400, height: 40)
//            }
//            .onChange(of: keyframeValue.progress) { _, newValue in
//                currentProgress = newValue
//            }
//        }
//    }
//
//    var body: some View {
//        progressBar
//    }
//}
//
//#Preview {
//    LoadingScreenView()
//}

//
//  ContentView.swift
//  NetworkRequest
//
//  Created by niccho on 7/12/2025.
//

import SwiftUI

struct LoadedImageView: View {
    let cgImage: CGImage?

    var body: some View {
        if let cgImage {
            Image(cgImage, scale: 1.0, label: Text("Robot"))
        } else {
            Text("no robot yet")
        }
    }
}

struct RobotView: View {
    @State private var cgImage: CGImage?
    
    var body: some View {
        LoadedImageView(cgImage: CGImage)
            .onAppear {
                loadImageWithGCD()
            }
    }

    private func loadImageWithGCD() {
        let request = URLRequest(url: URL(string: "https://robohash.org/hash-this-text.png")!)

        let dataTask = URLSession.shared.dataTask(with: request) { data, _, _ in
            guard let data else { return }

            DispatchQueue.main.async {
                let provider = CGDataProvider(data: data as CFData)!

                self.cgImage = CGImage(
                    pngDataProviderSource: provider,
                    decode: nil,
                    shouldInterpolate: false,
                    intent: .defaultIntent
                )
            }
        }

        dataTask.resume()
    }
}

#Preview {
    RobotView()
}

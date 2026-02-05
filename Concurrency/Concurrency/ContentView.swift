import SwiftUI

struct ContentView: View {
    actor TextDownloader {
        func download() async throws -> String {
            try await Task.sleep(for: .seconds(3))
            return "After"
        }
    }

    @State private var myString = "Before"

    let textDownloader = TextDownloader()

    var body: some View {
        Text(myString)
            .font(.largeTitle)
            .onTapGesture {
                Task {
                    let text = try await textDownloader.download()
                    show(text: text)
                }
            }
    }

    func show(text: String) {
        myString = text
    }
}

#Preview {
    ContentView()
}

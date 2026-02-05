
import SwiftUI

struct AbsoluteView: View {
    var body: some View {
        Text("Hello, world!")
            .background(.red)
            .offset(x: 100, y: 100)
    }
}

#Preview {
    AbsoluteView()
}

import SwiftUI

struct GeoView: View {
    var body: some View {
        HStack {
            Text("IMPORTANT")
                .frame(width: 200)
                .background(.blue)

            GeometryReader { geo in
                Image(.paulHudson)
                    .resizable()
                    .scaledToFit()
                    .frame(width: geo.size.width * 0.8)
//                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .border(.blue)
            }
            .border(.red)
        }
    }
}

#Preview {
    GeoView()
}



import SwiftUI

struct EmojiRatingView: View {
    let rating: Int
    var body: some View {
        switch rating {
        case 1:
            Text("😔")
                .font(.system(size: 32))
        case 2:
            Text("😕")
                .font(.system(size: 32))
        case 3:
            Text("😐")
                .font(.system(size: 32))
        case 4:
            Text("😃")
                .font(.system(size: 32))
        default:
            Text("😍")
                .font(.system(size: 32))
        }
    }
}

#Preview {
    HStack {
        EmojiRatingView(
            rating: 1
        )
        EmojiRatingView(
            rating: 2
        )
        EmojiRatingView(
            rating: 3
        )
        EmojiRatingView(
            rating: 4
        )
        EmojiRatingView(
            rating: 5
        )
    }
}

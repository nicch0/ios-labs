//
//  CustomAlignmentView.swift
//  LayoutAndGeometry
//
//  Created by niccho on 2/12/2025.
//

import SwiftUI

extension VerticalAlignment {
    struct MidAccountAndName: AlignmentID {
        static func defaultValue(in context: ViewDimensions) -> CGFloat {
            context[.top]
        }
    }

    static let midAccountAndName = VerticalAlignment(MidAccountAndName.self)
}

struct CustomAlignmentView: View {
    var body: some View {
        HStack(alignment: .midAccountAndName) {
            VStack {
                Text("@twostraws")
                    .alignmentGuide(.midAccountAndName) { d in d[VerticalAlignment.center] }
                Image(.paulHudson)
                    .resizable()
                    .frame(width: 64, height: 64)
            }

            VStack {
                Text("Full name:")
                Text("PAUL HUDSON")
                    .alignmentGuide(.midAccountAndName) { d in
                        d[VerticalAlignment.center]
                    }
                    .font(.largeTitle)
            }
        }
    }
}

#Preview {
    CustomAlignmentView()
}

//
//  AlignmentView.swift
//  LayoutAndGeometry
//
//  Created by niccho on 2/12/2025.
//

import SwiftUI

struct AlignmentView: View {
    var body: some View {
        Text("Live long and prosper")
            .frame(width: 300, height: 300, alignment: .bottomLeading)
            .border(.red)

        HStack(alignment: .lastTextBaseline) {
            Text("Live")
                .font(.caption)
            Text("long")
            Text("and")
                .font(.title)
            Text("prosper")
                .font(.largeTitle)
        }
        
        VStack(alignment: .leading, spacing: 20) {
            Text("Short")
                .background(.red)
                .alignmentGuide(.leading) { d in
                    d.width / 2  // Align by my horizontal center
                }
            
            Text("Medium text")
                .background(.green)
                .alignmentGuide(.leading) { d in
                    d.width  // Align by my trailing edge
                }
            
            Text("This is a really long line")
                .background(.blue)
                // No alignment guide - uses actual leading edge
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(.yellow)
    }
}

#Preview {
    AlignmentView()
}

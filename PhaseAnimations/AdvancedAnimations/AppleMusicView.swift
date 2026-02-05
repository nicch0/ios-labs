//
//  AppleMusicView.swift
//  PhaseAnimations
//
//  Created by niccho on 2/12/2025.
//

import SwiftUI

struct AppleMusicView: View {
    
    @Namespace private var animation
    @State private var isZoomed = false

    var frame: Double {
        isZoomed ? 300 : 44
    }

    var body: some View {
        VStack {
            VStack {
                HStack {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(.blue)
                        .frame(width: frame, height: frame)
                        .padding(.top, isZoomed ? 20 : 0)

                    if isZoomed == false {
                        Text("1989 by Taylor Swift")
                            .matchedGeometryEffect(id: "AlbumTitle", in: animation)
                            .font(.headline)
                        Spacer()
                    }
                }
                if isZoomed == true {
                    Text("Taylor Swift – 1989")
                        .matchedGeometryEffect(id: "AlbumTitle", in: animation)
                        .font(.title)
                        .padding(.bottom, 60)
                    Spacer()
                }
            }
            .onTapGesture {
                withAnimation(.spring(duration: 0.2)) {
                    isZoomed.toggle()
                }
            }
            .padding()
            .frame(maxWidth: .infinity)
            .frame(height: 400)
            .background(Color(white: 0.9))
            .foregroundStyle(.black)
        }
    }
}

#Preview {
    AppleMusicView()
}

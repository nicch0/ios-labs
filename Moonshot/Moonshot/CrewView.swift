//
//  CrewView.swift
//  Moonshot
//
//  Created by niccho on 8/11/2025.
//

import SwiftUI

struct CrewView: View {
    let crew: [CrewMember]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 30) {
                ForEach(crew, id: \.role) { member in
                    NavigationLink(value: member.astronaut) {
                        HStack {
                            Image(member.astronaut.id)
                                .resizable()
                                .frame(width: 104, height: 72)
                                .clipShape(.capsule)
                                .overlay(Capsule().strokeBorder(.white, lineWidth: 1))

                            VStack(alignment: .leading) {
                                Text(member.astronaut.name)
                                    .font(.headline)
                                    .foregroundStyle(.white)
                                Text(member.role)
                                    .foregroundStyle(.white.opacity(0.5))
                            }
                        }
                    }
                }
            }
            .padding(.horizontal)
        }
    }
}

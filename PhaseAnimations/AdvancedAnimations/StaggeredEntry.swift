//
//  WithAndWithoutView.swift
//  PhaseAnimations
//
//  Created by niccho on 1/12/2025.
//

import SwiftUI

private enum Gender: String, CaseIterable {
    case male, female, other
}

struct StaggeredEntryView: View {
    let selectedGenderColor = Color(#colorLiteral(red: 0.1235430017, green: 0.09799291939, blue: 0.143384248, alpha: 1))
    let unSelectedGenderColor = Color(#colorLiteral(red: 0.9760739207, green: 0.9760745168, blue: 0.9900050759, alpha: 1))

    @State private var selectedGender: Gender?

    @State private var showButtons = false

    var body: some View {
        VStack(alignment: .leading) {
            Spacer().frame(height: 50)
            Text("Choose your Gender")
                .font(.largeTitle)
                .fontWeight(.semibold)

            Text("This will be used to calibrate your custom plan.")
                .font(.headline)
                .opacity(0.5)

            Spacer()
            VStack {
                ForEach(Gender.allCases.enumerated(), id: \.offset) { idx, gender in
                    Button {
                        selectedGender = gender
                    } label: {
                        RoundedRectangle(cornerRadius: 20)
                            .fill(selectedGender == gender ? selectedGenderColor : unSelectedGenderColor)
                            .frame(height: 100)
                            .overlay {
                                Text(gender.rawValue.capitalized)
                                    .font(.headline)
                                    .foregroundStyle(selectedGender == gender ? .white : .black)
                            }
                    }
                    .buttonStyle(.plain)
                    .opacity(showButtons ? 1 : 0)
                    .animation(.easeOut.delay(Double(idx) * 0.1), value: showButtons)
                }
            }

            Spacer()
        }
        .padding(.horizontal, 30)
        .fontDesign(.rounded)
        .onAppear {
            showButtons = true
        }

        Button {
            reset()
        } label: {
            Label("Reset", systemImage: "arrow.trianglehead.clockwise.rotate.90")
                .foregroundStyle(.white)
        }
        .frame(width: 300)
        .tint(.black)
        .buttonStyle(.borderedProminent)

        Spacer()
        Spacer()
    }

    func reset() {
        showButtons = false

        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            showButtons = true
        }
    }
}

#Preview {
    StaggeredEntryView()
}

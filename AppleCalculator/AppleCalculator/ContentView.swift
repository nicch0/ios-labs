//
//  ContentView.swift
//  AppleCalculator
//
//  Created by niccho on 4/11/2025.
//

import SwiftUI

extension ShapeStyle where Self == Color {
    static var darkBackground: Color {
        Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1))
    }

    static var operand: Color {
        Color(#colorLiteral(red: 1, green: 0.6068655252, blue: 0.1813479364, alpha: 1))
    }

    static var main: Color {
        Color(#colorLiteral(red: 0.2126713991, green: 0.2126714587, blue: 0.2126714587, alpha: 1))
    }

    static var utility: Color {
        Color(#colorLiteral(red: 0.4010861516, green: 0.4010861516, blue: 0.4010861516, alpha: 1))
    }
}

struct CalculatorButton: View {
    var systemName: String?
    var text: String?
    var background: Color
    var size: CGFloat?

    var body: some View {
        /**
         Compared to reference:
         - No reflection from surrounding buttons
         - Some buttons are below the others when dragged (e.g. button 9)
         */
        if let systemName {
            Button {
                print("button tapped")
            } label: {
                Circle()
                    .fill(background)
                    .overlay(
                        Image(systemName: systemName)
                            .resizable()
                            .scaledToFit()
                            .frame(width: size ?? 26, height: size ?? 26)
                    )
            }
            .frame(width: 90, height: 90)
            .glassEffect(.regular.interactive(), in: Circle())
        } else if let text {
            // Button view -> Add Circle overlayed with Text
            Button {
                print("button tapped")
            } label: {
                Circle()
                    .fill(background)
                    .overlay(
                        // Overlay Text view on top of shape
                        Text(text)
                            .font(.system(size: 36))
                    )
            }
            .frame(width: 90, height: 90)
            .glassEffect(.regular.interactive(), in: Circle())
        }
    }
}

struct ContentView: View {
    // MARK: This be the start

    var body: some View {
        VStack {
            VStack(alignment: .trailing) {
                Spacer()
                Text("RESULTS")
                    .frame(maxWidth: .infinity, alignment: .trailing)
                Text("12345")
                    .frame(maxWidth: .infinity, alignment: .trailing)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            Grid {
                GridRow {
                    CalculatorButton(
                        systemName: "delete.backward",
                        background: .utility,
                        size: CGFloat(32)
                    )
                    CalculatorButton(text: "AC", background: .utility)
                    CalculatorButton(systemName: "percent", background: .utility)
                    CalculatorButton(systemName: "divide", background: .operand)
                }
                GridRow {
                    CalculatorButton(text: "7", background: .main)
                    CalculatorButton(text: "8", background: .main)
                    CalculatorButton(text: "9", background: .main)
                    CalculatorButton(systemName: "multiply", background: .operand)
                }
                GridRow {
                    CalculatorButton(text: "4", background: .main)
                    CalculatorButton(text: "5", background: .main)
                    CalculatorButton(text: "6", background: .main)
                    CalculatorButton(systemName: "minus", background: .operand)
                }
                GridRow {
                    CalculatorButton(text: "1", background: .main)
                    CalculatorButton(text: "2", background: .main)
                    CalculatorButton(text: "3", background: .main)

                    CalculatorButton(systemName: "plus", background: .operand)
                }
                GridRow {
                    CalculatorButton(systemName: "plus.forwardslash.minus", background: .main)
                    CalculatorButton(text: "0", background: .main)
                    CalculatorButton(text: ".", background: .main)
                    CalculatorButton(systemName: "equal", background: .operand)
                }
            }
            .frame(maxWidth: .infinity)
        }
        .foregroundStyle(.white)
        .font(.system(size: 72))
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.darkBackground)
    }

    // MARK: LOL
}

#Preview {
    ContentView()
}

//
//  ContentView.swift
//  CircularProgressIcon
//
//  Created by niccho on 3/11/2025.
//

// Build a circular progress indicator that fills clockwise from the top
// Requirements:
// Circle outline that fills based on a progress value (0.0 to 1.0)
// User can drag a slider to change the progress
// The filled portion should be a different color than the unfilled portion
// Starts at 12 o'clock position, goes clockwise

//Animate the progress smoothly when it changes
//Add a small circle "knob" at the end of the progress arc (this requires calculating a point on the circle's circumference - definitely uses trig)



import SwiftUI


extension Angle {
    func rotatedToTopStart() -> Angle {
        Angle(degrees: self.degrees - 90.0)
    }
}

struct Arc: Shape {
    var progressValue: Double = 0.0
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        // So we go from 0.0 to 1.0 out of a total of 360 degrees
        let startAngle = Angle(radians: 0).rotatedToTopStart()
        let endAngle = Angle(radians: progressValue * 2.0 * Double.pi).rotatedToTopStart()
        
        path
            .addArc(
                center: CGPoint(x: rect.midX, y: rect.midY),
                radius: rect.width / 2,
                startAngle: startAngle,
                endAngle: endAngle,
                clockwise: false
            )
        
        return path
    }
}



struct ContentView: View {
    @State private var progressValue: Double = 0.5
    
    private var knobOffset: CGSize {
        let radius: CGFloat = 100
        let angle = (progressValue * 2.0 * Double.pi) - (Double.pi / 2.0)
        
        let x = radius * cos(angle)
        let y = radius * sin(angle)
        
        return CGSize(width: x, height: y)
    }
    
    var body: some View {
        VStack {
            Spacer()
            ZStack {
                Arc(progressValue:1.0)
                    .stroke(.gray.opacity(0.5), style: StrokeStyle(lineWidth: 25, lineCap: .round))
                    .frame(width: 200, height: 200)
                
                Arc(progressValue: progressValue)
                    .stroke(.blue, style: StrokeStyle(lineWidth: 25, lineCap: .round))
                    .frame(width: 200, height: 200)
                
                // Then in body:
                Circle()
                    .fill(.yellow)
                    .frame(width: 25, height: 25)
                    .offset(knobOffset)
                
            }
            Spacer()

            Slider(value: $progressValue.animation(), in: 0.0...1.0, step: 0.25)

        }
        .padding()
    }
}

#Preview {
    ContentView()
}

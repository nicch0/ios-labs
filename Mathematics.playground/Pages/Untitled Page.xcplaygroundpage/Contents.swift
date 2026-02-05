// Implement these functions:

import Foundation

func easeInQuad(_ t: Double) -> Double {
    // Accelerating from zero velocity
    // Uses: t²
    pow(t, 2)
}

func easeOutQuad(_ t: Double) -> Double {
    // Decelerating to zero velocity
    // Uses: 1 - (1-t)²

    1.0 - pow(1.0 - t, 2.0)
}

func easeInOutQuad(_ t: Double) -> Double {
    // Acceleration until halfway, then deceleration
    
    if t < 0.5 {
        return 2 * t * t
    } else {
        // c + (v-a) * (1-0)/(1-0.5)
        // (v-0.5) * 2
        // 2v - 1
        let scaledT = 2 * t - 1
        
        // c + (v-a) * (0.5)/(1)
        // 0.5 + (v-0) * 1/2
        // 1/2 + 1/2 v
        return 0.5 * easeOutQuad(scaledT) + 0.5
        
        
    }
}

func easeInCubic(_ t: Double) -> Double {
    // Stronger acceleration
    // Uses: t³
    pow(t, 3.0)
}

// Should print 0.0, 0.25, 1.0
print(easeInQuad(0.0))
print(easeInQuad(0.5))
print(easeInQuad(1.0))

// Should print 0.0, 0.75, 1.0
print(easeOutQuad(0.0))
print(easeOutQuad(0.5))
print(easeOutQuad(1.0))

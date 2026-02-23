//
//  TemperatureLogger.swift
//  SwiftConcurrencyLabs
//
//  Created by niccho on 19/2/2026.
//
import Foundation

actor TemperatureLogger {
    let label: String
    var measurements: [Int]
    private(set) var max: Int

    init(label: String, measurement: Int) {
        self.label = label
        measurements = [measurement]
        self.max = measurement
    }
}

extension TemperatureLogger {
    func convertFahrenheitToCelsius() async {
        for i in measurements.indices {
            measurements[i] = try! await getCelsius(measurements[i])
        }
    }
}

func getCelsius(_ fahrenheit: Int) async throws -> Int {
    try await Task.sleep(for: .seconds(4))
    return (fahrenheit - 32) * 5 / 9
}

let logger = TemperatureLogger(label: "Outdoors", measurement: 32)

//// Task 1: converting fahrenheit to celsius
//Task {
//    await logger.convertFahrenheitToCelsius()
//    print("converted measurements: \(await logger.measurements)")
//}
//
//// Task 2: adds a new fahrenheit measurement while conversion is in progress
//Task {
//    try await Task.sleep(for: .seconds(2)) // sneaks in mid-conversion
//    await logger.update(with: 212) // 212°F = 100°C, but will it get converted?
//    print("added new measurement")
//}

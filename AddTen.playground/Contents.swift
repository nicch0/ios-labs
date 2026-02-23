//
//  Test.swift
//
//
//  Created by niccho on 19/2/2026.
//

//
//  CancelingTasks.swift
//  SwiftConcurrencyLabs
//
//  Created by niccho on 19/2/2026.
//

import Foundation

func addTen(_ val: Int) async -> Int {
    try! await Task.sleep(for: .seconds(2))
    print("Adding 10 to value \(val)")
    return val * 10
}

func addsTen(_ values: [Int]) async -> [Int] {
    await withTaskGroup(of: Int.self) { group in
        for value in values {
            group.addTask {
                await addTen(value)
            }
        }

        var results: [Int] = []

        for await result in group {
            results.append(result)
        }

        return results
    }
}

let unstructuredTask = Task {
    let values = [2, 3, 4, 5]

    let res = await addsTen(values)
    print(res)
}



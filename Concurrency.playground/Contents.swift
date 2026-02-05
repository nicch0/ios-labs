struct WeatherData {
    let city: String
    let temperature: Double
    let condition: String
}

func fetchWeather(for city: String) async throws -> WeatherData {
    // Simulates network call that might fail
    try await Task.sleep(for: .seconds(Double.random(in: 0.5 ... 2.0)))
    return WeatherData(city: city, temperature: Double.random(in: 15 ... 30), condition: "Sunny")
}

let cities = ["Auckland", "Sydney", "Tokyo", "London", "New York"]

func fetchAllWeather(cities: [String]) async throws -> [WeatherData] {
    try await withThrowingTaskGroup(of: WeatherData.self) { group in
        // initialise all tasks to run in parallel
        for city in cities {
            group.addTask {
                try await fetchWeather(for: city)
            }
        }
        
        // collect results
        var results: [WeatherData] = []
        for try await weather in group {
            results.append(weather)
        }
        
        return results
    }
}

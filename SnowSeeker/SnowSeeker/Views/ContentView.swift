import SwiftUI

struct ContentView: View {
    @State private var searchText = ""
    
    let resorts: [Resort] = Bundle.main.decode("resorts.json")
    
    var filteredResorts: [Resort] {
        if searchText.isEmpty {
            resorts
        } else {
            resorts.filter {
                $0.name.localizedStandardContains(searchText)
            }
        }
    }

    var body: some View {
        NavigationSplitView {
            List(filteredResorts) { resort in
                NavigationLink(value: resort) {
                    HStack(spacing: 20) {
                        Image(resort.country)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 40, height: 20)

                        VStack(alignment: .leading) {
                            Text(resort.name)
                                .font(.headline)
                            Text("\(resort.runs) runs")
                                .foregroundStyle(.secondary)
                        }
                    }
                }
            }
            .searchable(text: $searchText, prompt: "Search for a resort")
            .navigationTitle("Resorts")
            .navigationDestination(for: Resort.self) { resort in
                ResortView(resort: resort)
            }
        } detail: {
            WelcomeView()
        }
    }
}

#Preview {
    ContentView()
}

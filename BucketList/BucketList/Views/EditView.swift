//
//  EditView.swift
//  BucketList
//
//  Created by niccho on 17/11/2025.
//

import SwiftUI

struct EditView: View {
    var location: Location

    @Environment(\.dismiss) var dismiss
    var onSave: (Location) -> Void

    @State private var viewModel = ViewModel()
    @State private var name: String
    @State private var description: String

    init(location: Location, onSave: @escaping (Location) -> Void) {
        self.location = location
        self.onSave = onSave

        _name = State(initialValue: location.name)
        _description = State(initialValue: location.description)
    }

    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Place name", text: $name)
                    TextField("Description", text: $description)
                }

                Section {
                    if viewModel.loadingState == .loading {
                        Text("Loading...")
                    } else if viewModel.loadingState == .failed {
                        Text("Please try again later")
                    } else {
                        ForEach(viewModel.pages, id: \.pageid) { page in
                            VStack(alignment: .leading) {
                                Text("\(page.title)")
                                    .font(.headline)
                                Text("\(page.description)")
                                    .italic()
                            }
                        }
                    }
                }
            }
            .navigationTitle("Place Details")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                Button("Save") {
                    var newLocation = location
                    newLocation.id = UUID()
                    newLocation.name = name
                    newLocation.description = description

                    onSave(newLocation)
                    dismiss()
                }
            }
            .task {
                await viewModel.fetchNearbyPlaces(location: location)
            }
        }
    }
}

#Preview {
    EditView(location: .example) { _ in }
}

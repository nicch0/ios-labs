//
//  AddPlace.swift
//  PlacesPlusFaces
//
//  Created by niccho on 23/11/2025.
//

import PhotosUI
import SwiftData
import SwiftUI

struct AddPlaceView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var modelContext

    let locationFetcher = LocationFetcher()

    @State private var selectedPhoto: PhotosPickerItem?
    @State private var imageData: Data?

    @State private var name = ""
    @State private var showingPhotosPicker = false
    @State private var includesCurrentLocation = false

    @FocusState private var nameIsFocused: Bool

    // TODO: Add support for live photos
    var body: some View {
        VStack {
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .aspectRatio(1.0, contentMode: .fit)
                .overlay {
                    PhotosPicker(selection: $selectedPhoto, matching: .any(of: [.images, .not(.screenshots)]), photoLibrary: .shared()) {
                        if let data = imageData, let uiImage = UIImage(data: data) {
                            let image = Image(
                                uiImage: uiImage
                            )
                            image
                                .resizable()
                                .scaledToFill()
                        } else {
                            ContentUnavailableView("No Picture", systemImage:
                                "photo.badge.plus", description: Text("Tap to import a photo"))
                                .foregroundStyle(.black)
                                .background(.white)
                        }
                    }
                }
                .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                .photosPicker(isPresented: $showingPhotosPicker, selection: $selectedPhoto, matching: .any(of: [.images, .not(.screenshots)]), photoLibrary: .shared())
                .padding(.bottom).onChange(of: selectedPhoto, loadImage)
                .onAppear {
                    showingPhotosPicker = true
                }

            TextField("ADD NAME...", text: $name)
                .font(.title3)
                .padding()
                .multilineTextAlignment(.center)
                .focused($nameIsFocused)
                .background(.gray.opacity(0.2))
                .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))

            Spacer()
                .frame(height: 50)

            Toggle(
                "Include Current Location",
                systemImage: "location.fill",
                isOn: $includesCurrentLocation
            )
            .foregroundStyle(includesCurrentLocation ? .blue : .black)
            .onChange(of: includesCurrentLocation) { _, newValue in
                if newValue == true {
                    locationFetcher.start()
                }
            }

            Spacer()
        }
        .padding()
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button(role: .cancel) {
                    dismiss()
                }
            }

            ToolbarItem(placement: .confirmationAction) {
                Button(role: .confirm) {
                    addPlace()
                    dismiss()
                }
                .buttonStyle(.glassProminent)
                .tint(.black)
            }
        }
    }

    func loadImage() {
        Task {
            guard let imageData = try await selectedPhoto?.loadTransferable(type: Data.self) else { return }
            self.imageData = imageData
            nameIsFocused = true
        }
    }

    func addPlace() {
        print("Adding place")
        guard let imageData else { return }

        var location: CLLocationCoordinate2D?
        if includesCurrentLocation {
            location = locationFetcher.lastKnownLocation
        }

        let post = Post(
            name: name,
            imageData: imageData,
            createdAt: .now,
            location: location?.toCoordinate2D()
        )

        modelContext.insert(post)
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Post.self, configurations: config)

        return NavigationStack {
            AddPlaceView()
        }.modelContainer(container)
    } catch {
        return Text("Failed")
    }
}

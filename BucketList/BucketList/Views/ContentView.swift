//
//  ContentView.swift
//  BucketList
//
//  Created by niccho on 17/11/2025.
//

// Allow the user to switch map modes, between the standard mode and hybrid.
// Our app silently fails when errors occur during biometric authentication, so add code to show those errors in an alert.
// Create another view model, this time for EditView. What you put in the view model is down to you, but I would recommend leaving dismiss and onSave in the view itself – the former uses the environment, which can only be read by the view, and the latter doesn’t really add anything when moved into the model.
//
// Tip: That last challenge will require you to make a State instance in your EditView initializer – remember to use an underscore with the property name!

import LocalAuthentication
import MapKit
import SwiftUI

enum SelectedMapStyle {
    case standard, hybrid

    var style: MapStyle {
        switch self {
        case .hybrid: return MapStyle.hybrid
        case .standard: return MapStyle.standard
        }
    }
}

struct ContentView: View {
    @State private var viewModel = ViewModel()

    @State private var mapStyle: SelectedMapStyle = .standard

    @State private var showingAlert = false
    
    let startPosition = MapCameraPosition.region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 56, longitude: -3),
            span: MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10)
        )
    )

    var body: some View {
        ZStack {
            MapReader { proxy in
                Map(initialPosition: startPosition) {
                    ForEach(viewModel.locations) { location in
                        Annotation(location.name, coordinate: location.coordinate) {
                            Image(systemName: "star.fill")
                                .resizable()
                                .foregroundStyle(.yellow)
                                .frame(width: 30, height: 30)
                                .clipShape(.circle)
                                .contentShape(.circle)
                                .onLongPressGesture(minimumDuration: 0.2) {
                                    viewModel.selectedPlace = location
                                }
                        }
                    }
                }
                .mapStyle(mapStyle.style)
                .simultaneousGesture(SpatialTapGesture().onEnded { event in
                    if let coordinate = proxy.convert(event.location, from: .local) {
                        viewModel.addLocation(at: coordinate)
                    }
                })
            }

            Button {
                if mapStyle == .standard {
                    mapStyle = .hybrid
                } else {
                    mapStyle = .standard
                }
            } label: {
                Image(systemName: "map.fill")
            }
            .buttonStyle(.borderedProminent)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
            .padding()
        }
        .sheet(item: $viewModel.selectedPlace) { place in
            EditView(location: place) { newLocation in
                viewModel.updateLocation(newLocation)
            }
        }

        .overlay {
            if !viewModel.isUnlocked {
                ZStack {
                    Rectangle()
                        .glassEffect(.clear, in: Rectangle())
                    Color.black.opacity(0.4)
                    VStack {
                        Spacer()
                        Text("BucketList")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .fontDesign(.rounded)
                            .foregroundStyle(
                                .white
                            )
                        Spacer()

                        Button("Unlock Places", action: viewModel.authenticate)
                            .padding()
                            .background(.blue)
                            .foregroundStyle(.white)
                            .clipShape(.capsule)
                            .onChange(of: viewModel.error) { _, newValue in
                                if newValue != nil {
                                    showingAlert = true
                                }
                            }
                        Spacer()
                    }
                }
                .ignoresSafeArea()
                .contentShape(Rectangle())
                .onTapGesture {}
            }
        }
        .alert("Error authenticating FaceID", isPresented: $showingAlert) {
            Button("OK") {}
        } message: {
            Text(viewModel.error ?? "Error")
        }
    }
}

#Preview {
    NavigationStack {
        ContentView()
    }
}

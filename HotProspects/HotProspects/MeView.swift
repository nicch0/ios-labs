//
//  MeView.swift
//  HotProspects
//
//  Created by niccho on 25/11/2025.
//

import CoreImage.CIFilterBuiltins
import SwiftData
import SwiftUI



struct MeView: View {
    @AppStorage("name") private var name = "Anonymous"
    @AppStorage("emailAddress") private var emailAddress = "you@yoursite.com"

    @State private var qrCode = UIImage()

    let context = CIContext()
    let filter = CIFilter.qrCodeGenerator()

    var body: some View {
        NavigationStack {
            Form {
                TextField("Name", text: $name)
                    .textContentType(.name)
                    .font(.title2)

                TextField("Email address", text: $emailAddress)
                    .textContentType(.emailAddress)
                    .font(.title3)

                Section("Your Code") {
                    HStack {
                        Spacer()
                        Image(uiImage: qrCode)
                            .interpolation(.none)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 200, height: 200)
                            .contextMenu {
                                let image = Image(uiImage: qrCode)
                                ShareLink(item: image, preview: SharePreview("My QR Code", image: image))
                            }
                        Spacer()
                    }
                }
            }
            .navigationTitle("Me")
            .onAppear(perform: updateCode)
            .onChange(of: name, updateCode)
            .onChange(of: emailAddress, updateCode)
        }
    }

    func updateCode() {
        qrCode = generateQRCode(from: "\(name)\n\(emailAddress)")
    }

    func generateQRCode(from string: String) -> UIImage {
        filter.message = Data(string.utf8)

        if let outputImage = filter.outputImage {
            if let cgImage = context.createCGImage(outputImage, from: outputImage.extent) {
                return UIImage(cgImage: cgImage)
            }
        }

        return UIImage(systemName: "xmark.circle") ?? UIImage()
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Prospect.self, configurations: config)
        return NavigationStack {
            MeView()
        }.modelContainer(container)
    } catch {
        return Text("Failed to create preview")
    }
}

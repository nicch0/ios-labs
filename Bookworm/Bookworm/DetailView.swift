//
//  File.swift
//  Bookworm
//
//  Created by niccho on 11/11/2025.
//

import SwiftData
import SwiftUI

struct DetailView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss

    let book: Book

    @State private var showDeleteConfirmation = false

    var body: some View {
        ScrollView {
            Image(book.genre)
                .resizable()
                .scaledToFit()
                .padding(.bottom)

            VStack {
                VStack(spacing: 16) {
                    Text(book.genre.uppercased())
                        .font(.caption)
                        .fontWeight(.black)
                        .padding(8)
                        .foregroundStyle(.white)
                        .background(.green.opacity(0.75))
                        .clipShape(.capsule)
                        .offset(x: -5, y: -5)

                    VStack {
                        Text(book.title)
                            .font(.title.bold())
                        Text(book.author)
                            .font(.subheadline.italic())
                        Text(
                            "\(book.reviewDate.formatted(date: .complete, time: .shortened))"
                        )
                        .font(.subheadline.italic())
                    }

                    Text(book.review)
                        .padding()

                    RatingView(rating: .constant(book.rating))
                        .font(.subheadline)
                }
                Spacer()

                Divider()
                    .padding()

                Button("Delete Review", systemImage: "trash") {
                    showDeleteConfirmation = true
                }
                .foregroundStyle(.red)
            }
        }
        .alert("Delete book", isPresented: $showDeleteConfirmation) {
            Button("Delete", role: .destructive, action: deleteBook)
            Button("Cancel", role: .cancel) {}
        } message: {
            Text("Are you sure?")
        }
        .ignoresSafeArea()
        .scrollBounceBehavior(.basedOnSize)
    }

    func deleteBook() {
        modelContext.delete(book)
        dismiss()
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)

        let container = try ModelContainer(for: Book.self, configurations: config)

        let example = Book(title: "Test Book", author: "Test Author", genre: "Fantasy", review: "This was a great book; I really enjoyed it.", rating: 4)

        return DetailView(book: example)
            .modelContainer(container)
    } catch {
        return Text("Failed to create preview")
    }
}

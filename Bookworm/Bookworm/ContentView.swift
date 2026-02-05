//
//  ContentView.swift
//  Bookworm
//
//  Created by niccho on 10/11/2025.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    @Query(sort: [
        SortDescriptor(\Book.title, order: .reverse),
        SortDescriptor(\Book.author),
    ]) var books: [Book]
    @State private var showNewBookReviewSheet = false

    var body: some View {
        NavigationStack {
            List {
                ForEach(books) { book in
                    NavigationLink(value: book) {
                        HStack {
                            VStack(alignment: .leading) {
                                Text(book.title)
                                    .font(.headline.bold())
                                    .foregroundStyle(book.rating == 1 ? .red : .black)

                                Text(book.author)
                                    .font(.subheadline.italic())
                                    .foregroundStyle(book.rating == 1 ? .red : .black)
                            }
                            Spacer()

                            EmojiRatingView(rating: book.rating)
                        }
                    }
                }
                .onDelete(perform: deleteBooks)
            }
            .navigationDestination(for: Book.self) { book in
                DetailView(book: book)
            }
            .navigationTitle("Bookworm")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Add Review") {
                        showNewBookReviewSheet = true
                    }
                }

                ToolbarItem(placement: .topBarLeading) {
                    EditButton()
                }
            }
            .sheet(isPresented: $showNewBookReviewSheet) {
                NavigationStack {
                    NewBookView()
                }
            }
        }
    }

    func deleteBooks(at offsets: IndexSet) {
        for offset in offsets {
            let book = books[offset]
            modelContext.delete(book)
        }
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Book.self, configurations: config)
        return ContentView().modelContainer(container)
    } catch {
        return Text("Failed to create preview")
    }
}

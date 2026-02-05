
import SwiftData
import SwiftUI

struct NewBookView: View {
    @Environment(\.modelContext) var modelContext
    @State private var title: String = ""
    @State private var author: String = ""
    @State private var genre: String = "Fantasy"
    @State private var review: String = ""
    @State private var rating: Int = 3
    
    @Environment(\.dismiss) var dismiss
    
    var formIsValid: Bool {
        return !title.isEmpty && !author.isEmpty && !genre.isEmpty
    }

    let genres = ["Fantasy", "Horror", "Kids", "Mystery", "Poetry", "Romance", "Thriller"]

    var body: some View {
        Form {
            Section {
                TextField("Title", text: $title)
                TextField("Author", text: $author)
                Picker("Genre", selection: $genre) {
                    ForEach(genres, id: \.self) { genre in
                        Text("\(genre)")
                    }
                }
            }

            Section("Write a Review") {
                TextEditor(text: $review)
                RatingView(rating: $rating)
            }
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("Save", systemImage: "plus") {
                    // add this book
                    let book = Book(
                        title: title,
                        author: author,
                        genre: genre,
                        review: review,
                        rating: rating
                    )
                    modelContext.insert(book)
                    dismiss()
                }
                .disabled(!formIsValid)
            }
        }
        .navigationTitle("New Book")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        NewBookView()
    }
}

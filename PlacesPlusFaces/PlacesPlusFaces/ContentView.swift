/**
 Have you ever been to a conference or a meetup, chatted to someone new, then realized seconds after you walk away that you’ve already forgotten their name? You’re not alone, and the app you’re building today will help solve that problem and others like it.

 Your goal is to build an app that asks users to import a picture from their photo library, then attach a name to whatever they imported. The full collection of pictures they name should be shown in a List, and tapping an item in the list should show a detail screen with a larger version of the picture.

 Breaking it down, you should:

     ✅ Use PhotosPicker to let users import a photo from their photo library.
     ✅ Detect when a new photo is imported, and immediately ask the user to name the photo.
     ✅ Save that name and photo somewhere safe.
     ✅ Show all names and photos in a list, sorted by ~~name~~ (created date)
     Create a detail screen that shows a picture full size.
     ✅ Decide on a way to save all this data.

 Remember to import the user's photo as Data, so you can write it out easily.

 You can use SwiftData for this project if you want to, but it isn’t required – a simple JSON file written out to the documents directory is fine, although you will need to add a custom conformance to Comparable to get array sorting to work.

 If you do choose to use SwiftData, here's an important tip: when storing large data like images or movies in your models, define them using a special @Attribute macro like this:

 @Attribute(.externalStorage) var photo: Data

 That tells SwiftData not to save the image data directly inside its database, but to put it alongside instead – it's much more efficient.
  */

import OnboardingKit
import SwiftData
import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    @Query(sort: \Post.createdAt, order: .reverse) var allPosts: [Post]
    @State private var showingSheet = false

    @State private var path = NavigationPath()

    var body: some View {
        NavigationStack(path: $path) {
            ScrollView {
                LazyVGrid(
                    columns: Array(repeating: GridItem(.flexible(), spacing: 1), count: 3), spacing: 1
                ) {
                    ForEach(allPosts) { post in
                        Rectangle()
                            .aspectRatio(1.0, contentMode: .fit)
                            .overlay {
                                if let image = post.image {
                                    image
                                        .resizable()
                                        .scaledToFill()
                                }
                            }
                            .clipShape(.rect)
                            .onTapGesture {
                                path.append(post)
                            }
                    }
                }
            }
            .sheet(isPresented: $showingSheet, content: {
                NavigationStack {
                    AddPlaceView()
                }
            })
            .toolbar {
                ToolbarItem(placement: .bottomBar) {
                    Button("Create", systemImage: "plus") {
                        showingSheet = true
                    }
                    .tint(.black)
                    .buttonStyle(.glassProminent)
                }
            }
            .navigationDestination(for: Post.self) { post in
                PostDetailView(post: post)
            }
        }
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Post.self, configurations: config)

        for example in Post.examples {
            container.mainContext.insert(example)
        }

        return NavigationStack {
            ContentView()
        }
        .modelContainer(container)
    } catch {
        return Text("Failed to create preview")
    }
}

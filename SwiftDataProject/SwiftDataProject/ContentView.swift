//
//  ContentView.swift
//  SwiftDataProject
//
//  Created by niccho on 12/11/2025.
//

import SwiftData
import SwiftUI



struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    @State private var showingUpcomingOnly = false
    @State private var path = [User]()

    @State private var sortOrder: [SortDescriptor<User>] =
        [
            SortDescriptor(\User.name),
            SortDescriptor(\User.joinDate),
        ]

    var body: some View {
        NavigationStack(path: $path) {
            VStack {
                UsersView(
                    minimumJoinDate: showingUpcomingOnly ? .now : .distantPast,
                    sortOrder: sortOrder
                )
            }
            .navigationTitle("Users")
            .navigationDestination(for: User.self) { user in
                EditUserView(user: user)
            }
            .toolbar {
                ToolbarItemGroup(placement: .topBarTrailing) {
                    Button("Add User", systemImage: "plus") {
                        let user = User(name: "", city: "", joinDate: .now)
                        modelContext.insert(user)
                        path = [user]
                    }

                    Button("Add Samples", systemImage: "paint.bucket.classic") {
                        do {
                            try modelContext.delete(model: User.self)

                            let first = User(name: "Ed Sheeran", city: "London", joinDate: .now.addingTimeInterval(86400 * -10))
                            let second = User(name: "Rosa Diaz", city: "New York", joinDate: .now.addingTimeInterval(86400 * -5))
                            let third = User(name: "Roy Kent", city: "London", joinDate: .now.addingTimeInterval(86400 * 5))
                            let fourth = User(name: "Johnny English", city: "London", joinDate: .now.addingTimeInterval(86400 * 10))
                            
                            let job1 = Job(name: "Organize sock drawer", priority: 3)
                            let job2 = Job(name: "Make plans with Alex", priority: 4)


                            first.jobs?.append(job1)
                            first.jobs?.append(job2)
                            
                            modelContext.insert(first)
                            modelContext.insert(second)
                            modelContext.insert(third)
                            modelContext.insert(fourth)

                            try modelContext.save()
                        } catch {
                            print("Failed to delete users: \(error)")
                            // Or show an alert to the user
                        }
                    }
                    Menu("Sort", systemImage: "arrow.up.arrow.down") {
                        Picker("Sort", selection: $sortOrder) {
                            Text("Name").tag(
                                [
                                    SortDescriptor(\User.name),
                                    SortDescriptor(\User.joinDate),
                                ])

                            Text("Join Date").tag([
                                SortDescriptor(\User.joinDate),
                                SortDescriptor(\User.name),
                            ])
                        }
                    }
                }

                ToolbarItem(placement: .topBarLeading) {
                    Button(
                        showingUpcomingOnly ? "Show Everyone" : "Show Upcoming"
                    ) {
                        showingUpcomingOnly.toggle()
                    }
                }

                ToolbarItem(placement: .principal) {}
            }
        }
    }
}

#Preview {
    ContentView()
}

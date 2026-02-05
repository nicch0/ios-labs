//
//  UsersView.swift
//  SwiftDataProject
//
//  Created by niccho on 12/11/2025.
//

// What we're going to do is move that list out into a separate view – a view specifically for running the SwiftData query and showing its results, then make it optionally show all users or only users who are joining in the future.

import SwiftData
import SwiftUI

struct UsersView: View {
    @Query(
        sort: \User.name
    ) var users: [User]

    init(minimumJoinDate: Date, sortOrder: [SortDescriptor<User>]) {
        let filter = #Predicate<User> { user in
            user.joinDate >= minimumJoinDate
        }
        
        _users = Query(filter: filter, sort: sortOrder)
    }

    var body: some View {
        List(users) { user in
            NavigationLink(value: user) {
                HStack{
                    Text(user.name)
                    Spacer()
                    
                    Text(String(user.jobs?.count ?? 0))
                        .fontWeight(.black)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 5)
                        .background(.blue)
                        .foregroundStyle(.white)
                        .clipShape(.capsule)
                }
            }
        }
    }
    
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: User.self, configurations: config)
        return UsersView(minimumJoinDate: .now, sortOrder: [SortDescriptor(\User.name)]).modelContainer(container)
    } catch {
        return Text("Failed to create preview")
    }
}

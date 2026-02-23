final class UserSession: Sendable {
    let username: String
    let authToken: String
    
    init(username: String, authToken: String) {
        self.username = username
        self.authToken = authToken
    }
}

let userSession = UserSession(username: "nicch0", authToken: "1234")

/**
 Initially compiler said:
 Type 'UserSession' does not conform to the 'Sendable' protocol
 We need UserSession to be Sendable bcos we're passing in data that can be modified (cos its a class)
 to a different concurrency domain (in the task). This means there might be a data race issue if
 another piece of code decided to modify the userSession while the Task is using it.
 
 Solution is to make it Sendable by limiting data access
 */
Task {
    userSession
}

Task {
    userSession
}



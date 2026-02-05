//
//  ContentView.swift
//  WordScramble
//
//  Created by niccho on 2/11/2025.
//

//    Disallow answers that are shorter than three letters or are just our start word.
//    Add a toolbar button that calls startGame(), so users can restart with a new word whenever they want to.
//    Put a text view somewhere so you can track and show the player’s score for a given root word. How you calculate score is down to you, but something involving number of words and their letter count would be reasonable.


import SwiftUI

enum FocusedField {
    case newWord
}

struct ContentView: View {
    @State private var usedWords = [String]()
    @State private var rootWord = ""
    @State private var newWord = ""
    
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showingError = false
    
    @State private var userScore = 0
    
    @FocusState private var focusedField: FocusedField?
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    VStack(spacing: 20.0) {
                        HStack {
                            Spacer()
                            Text(rootWord)
                                .font(.title)
                                .fontWeight(.bold)
                            Spacer()
                        }
                        if userScore > 0 {
                        HStack {
                            Spacer()
                            Text("Score: \(userScore)")
                                .font(.title2)
                            Spacer()
                        }
                        }
                    }
                    
                }
                .listRowBackground(Color.clear)
                Section {
                    TextField("Enter your word", text: $newWord)
                        .textInputAutocapitalization(.never)
                        .focused($focusedField, equals: .newWord)
                        .onAppear {
                            focusedField = .newWord
                        }
                }
                
                Section {
                    ForEach(usedWords, id: \.self) { word in
                        HStack {
                            Image(systemName: "\(word.count).circle")
                            Text(word)
                        }
                        .accessibilityElement()
                        .accessibilityLabel("\(word), \(word.count) letters")
                    }
                }
                
            }
            .onSubmit(addNewWord)
            .onAppear(perform: startGame)
            .alert(errorTitle, isPresented: $showingError) {} message: {
                Text(errorMessage)
            }
            .toolbar {
                Button("Start Over") {
                    startGame()
                }
            }

        }

    }
    
    func startGame() {
        userScore = 0
        usedWords = [String]()
        rootWord = ""
        newWord = ""
        
        if let startURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            if let startContents = try? String(contentsOf: startURL, encoding: .utf8) {
                let allWords = startContents.components(separatedBy: .whitespacesAndNewlines)
                    rootWord = allWords.randomElement() ?? "silkworm"
                return
            }
        }
        fatalError("Could not load start.txt")
    }
    
    func isOriginal(word: String) -> Bool {
        !usedWords.contains(word)
    }
    
    func isPossible(word: String) -> Bool {
        var tempWord = rootWord

        for letter in word {
            if let pos = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: pos)
            } else {
                return false
            }
        }

        return true
    }
    
    func isReal(word: String) -> Bool {
        let checker = UITextChecker()
        
        let range = NSRange(location: 0, length:word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        
        return misspelledRange.location == NSNotFound
    }
    
    func isLong(word: String) -> Bool {
        word.count >= 3
    }
    
    func isNotRootWord(word: String) -> Bool {
        word != rootWord
    }
    
    func wordError(title: String, message: String) {
        errorTitle = title
        errorMessage = message
        showingError = true
    }
    
    
    func addNewWord() {
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespaces)
        
        guard answer.count > 0 else {
            return
        }
        
        guard isOriginal(word: answer) else {
            wordError(title: "Word used already", message: "Be more original")
            return
        }

        guard isPossible(word: answer) else {
            wordError(title: "Word not possible", message: "You can't spell that word from '\(rootWord)'!")
            return
        }

        guard isReal(word: answer) else {
            wordError(title: "Word not recognized", message: "You can't just make them up, you know!")
            return
        }
        
        guard isLong(word: answer) else {
            wordError(title: "Word too short", message: "It's gotta be 3 characters or longer")
            return
        }
        
        guard isNotRootWord(word: answer) else {
            wordError(title: "Words is the same", message: "Bruh")
            return
        }
        
        withAnimation {
            usedWords.insert(answer, at: 0)
        }
        
        userScore += answer.count * usedWords.count
        
        focusedField = .newWord
        newWord = ""
    }
}

#Preview {
    ContentView()
}

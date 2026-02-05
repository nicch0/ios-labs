//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by niccho on 1/11/2025.
//

//So, very roughly:
//
//    Each turn of the game the app will randomly pick either rock, paper, or scissors.
//    Each turn the app will alternate between prompting the player to win or lose.
//    The player must then tap the correct move to win or lose the game.
//    If they are correct they score a point; otherwise they lose a point.
//    The game ends after 10 questions, at which point their score is shown.
//
//So, if the app chose “Rock” and “Win” the player would need to choose “Paper”, but if the app chose “Rock” and “Lose” the player would need to choose “Scissors”.


import SwiftUI

enum Choice: String, CaseIterable, Identifiable {
    case rock, paper, scissors
    var emoji: String {
        switch (self) {
        case .rock:
            return "🪨"
        case .paper:
            return "📃"
        case .scissors:
            return "✂️"
        }
    }
    
    var winsAgainst: Self {
        switch (self) {
        case .rock:
            return .scissors
        case .paper:
            return .rock
        case .scissors:
            return .paper
        }
    }
    
    var id: Self { self }
}

struct WinLoseText: View {
    var computerWinLose: Bool
    var body: some View {
        HStack(spacing: 0) {
            Text("You should ")
            Text(computerWinLose ? "win" : "lose")
                .foregroundStyle(computerWinLose ? .green : .red)
                .fontWeight(.bold)
        }
    }
}


struct ContentView: View {
    @State private var computerChoice = Choice.allCases.randomElement()!
    @State private var computerWinLose = true
    @State private var userScore = 0
    @State private var numberOfTurns = 0
    @State private var isGameOver = false
    
    var body: some View {
        ZStack{
            VStack(){
                Spacer()
                VStack {
                    Text(computerChoice.emoji)
                        .font(.system(size: 100))
                    WinLoseText(computerWinLose: computerWinLose)
                }.font(.largeTitle)
                
                Spacer()
                Spacer()
                
                HStack(spacing: 20) {
                    ForEach(Choice.allCases) { choice in
                        Button {
                            checkResult(userChoice: choice)
                        } label: {
                            Text(choice.emoji)
                        } .buttonStyle(.bordered)
                    }.font(.system(size: 80))
                }
                Spacer()
            }
            .alert("Game Over Buddy", isPresented: $isGameOver) {
                Button(action: startOver) {
                    Text("Start Over")
                }
            } message: {
                Text("Your final score was \(userScore)")
            }
        }

    }
    
    func startOver() {
        computerChoice = Choice.allCases.randomElement()!
        computerWinLose = true
        userScore = 0
        numberOfTurns = 0
        isGameOver = false
    }
    
    func checkResult(userChoice: Choice) {
        if (computerWinLose == true && userChoice.winsAgainst == computerChoice) || (
            !computerWinLose && computerChoice.winsAgainst == userChoice) {
            userScore += 1
        } else {
            userScore -= 1
        }
        numberOfTurns += 1
        
        if numberOfTurns == 10 {
            // game over!
            isGameOver = true
        } else {
            nextLevel()
        }
    }
    
    func nextLevel() {
        computerChoice = Choice.allCases.randomElement()!
        computerWinLose.toggle()
    }
}

#Preview {
    ContentView()
}

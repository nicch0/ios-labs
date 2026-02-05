//
//  ContentView.swift
//  Markiplier
//
//  Created by niccho on 3/11/2025.
//

//Your goal is to build an “edutainment” app for kids to help them practice multiplication tables – “what is 7 x 8?” and so on. Edutainment apps are educational at their core, but ideally have enough playfulness about them to make kids want to play.
//
//Breaking it down:
//
//    The player needs to select which multiplication tables they want to practice. This could be pressing buttons, or it could be an “Up to…” stepper, going from 2 to 12.
//    The player should be able to select how many questions they want to be asked: 5, 10, or 20.
//    You should randomly generate as many questions as they asked for, within the difficulty range they asked for.


/**
 Not gonna use separate screens for now
 UI: User inputs at the top (Top right will have the score), middle has the questions in large text followed by the text field
 */

// Lessons:
// Forms hijack your UI heaps. Only use it if you want to create Apple Settings-like scrollable views
// Otherwise, most of your composition can be done with XStacks
// You'll learn how to navigate between views in the future

import SwiftUI

struct ContentView: View {
    let numberQuestionsPossible = [5,10,15,20,25]
    @State private var timesTableSelected: Int = 6
    @State private var numQuestionsSelected: Int = 10
    
    @State private var questions: [Int] = []
    @State private var gameStarted: Bool = false
    @State private var numPoints: Int = 0
    @State private var currentQuestionIdx: Int = 0
    
    @State private var answer: String = ""
    @FocusState private var answerFieldFocused: Bool
    
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showingAlert = false
    
    @State private var minusButtonTapped = false
    
    var body: some View {
        VStack {
            if !gameStarted {
                VStack(spacing: 50) {
                    Spacer()
                    VStack(alignment: .center){
                        Text("Multiplication Table")
                            .font(.headline)
                        HStack(spacing: 30) {
                            Button {
                                if timesTableSelected > 2 {
                                    timesTableSelected -= 1
                                }
                            } label: {
                                Image(systemName: "minus.circle.fill")
                                    .font(.system(size: 56))
                            }
                            Text("\(timesTableSelected)")
                                .font(.system(size: 72))
                            Button {
                                if timesTableSelected < 12 {
                                    timesTableSelected += 1
                                }
                            } label: {
                                Image(systemName: "plus.circle.fill")

                                    .font(.system(size: 56))
                            }
                        }
                    
                    }
                    
                    VStack(alignment: .center) {
                        Text("Number of Questions")
                            .font(.headline)
                            .foregroundStyle(.white)
                        
                        Picker("Number of Questions", selection: $numQuestionsSelected) {
                            Text("5").tag(5)
                            Text("10").tag(10)
                            Text("20").tag(20)
                        }
                        .pickerStyle(.segmented)
                    }
                    
                    Button("Start Game") {
                        startGame()
                    }
                    .buttonStyle(.glass)
                    .frame(maxWidth: .infinity)
                    .listRowBackground(Color.clear)
                    Spacer()
                }
            } else {
                VStack {
                    Spacer()
                    Text("\((timesTableSelected)) x \(questions[currentQuestionIdx])")
                        .font(.system(size: 72))
                        .frame(maxWidth: .infinity, alignment: .center)
                        .listRowBackground(Color.clear)
                
                    HStack{
                        Spacer()
                        TextField("Enter your answer", text: $answer)
                            .font(.largeTitle)
                            .frame(alignment: .center)
                            .focused($answerFieldFocused)
                            .textInputAutocapitalization(.never)
                            .keyboardType(.numberPad)
                            .onAppear {
                                answerFieldFocused = true
                            }
                            .onSubmit {
                                answerQuestion()
                            }
                            .labelsHidden()
                        Spacer()
                    }
                    
                    Spacer()
                }
                .alert(alertTitle, isPresented: $showingAlert) {
                    Button("Play Again") {}
                } message: {
                    Text(alertMessage)
                }
            }
        }
        .padding(50)
        .background(.blue.gradient)
        .foregroundStyle(.white)
    }
    
    func answerQuestion() {
        if Int(answer) == questions[currentQuestionIdx] * timesTableSelected {
            // user is correct
            numPoints += timesTableSelected
            print("user is correct")
        } else {
            print("user is wrong")
        }
        
        // Check if game over
        if currentQuestionIdx == questions.count - 1 {
            print("Game over")
            alertTitle = "Game Over"
            alertMessage = "You scored \(numPoints) points!"
            showingAlert = true
        } else {
            // Go to next question
            currentQuestionIdx += 1
            answer = ""
            answerFieldFocused = true
        }
    }
    
    func startGame() {
        gameStarted = true
        numPoints = 0
        currentQuestionIdx = 0
        
        // Generate questions
        var questions: [Int] = []
        
        for _ in 0..<numQuestionsSelected {
            questions.append(Int.random(in: 1...10))
        }
        
        self.questions = questions
    }
    
    
}

#Preview {
    ContentView()
}

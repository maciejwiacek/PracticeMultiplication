//
//  GameView.swift
//  PracticeMultiplication
//
//  Created by Maciej Wiącek on 08/09/2023.
//

import SwiftUI
import Combine

struct GameView: View {
    @Environment(\.dismiss) var dismiss
    
    @Binding var number: Int
    @Binding var questionsAmount: Int
    
    @State private var currentQuestionNumber = 0
    @State private var userAnswer = ""
    @State private var correctAnswer = 0
    @State private var currentRound = 0
    @State private var userScore = 0
    
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var isAlertShown = false
    
    @State private var isGameFinished = false
    
    @State private var restart = false
    
    var body: some View {
        NavigationView {
            ZStack {
                NavigationLink(destination: ContentView(), isActive: $restart) {
                    Text("")
                }
                
                Color(red: 0.25, green: 0.16, blue: 0.39)
                    .ignoresSafeArea()
                VStack() {
                    Spacer()
                    
                    VStack(spacing: -15) {
                        Text("What is?")
                            .foregroundColor(.white)
                            .font(.system(size: 50).bold())
                        
                        Text("\(number)x\(currentQuestionNumber)")
                            .foregroundColor(.white)
                            .font(.system(size: 70).bold())
                    }
                    
                    Spacer()
                    
                    TextField("", text: $userAnswer)
                        .frame(width: 175, height: 160)
                        .background(Color(red: 0.33, green: 0.23, blue: 0.51))
                        .cornerRadius(15)
                        .multilineTextAlignment(.center)
                        .font(.system(size: 80).bold())
                        .foregroundColor(.white)
                        .onReceive(Just(userAnswer)) { _ in limitText(3) }
                        .keyboardType(.numberPad)
                        .tint(.clear)
                    
                    Spacer()
                    Spacer()
                    
                    Button("Submit") {
                        answerQuestion()
                    }
                    .frame(width: 300, height: 70)
                    .background(Color(red: 0.45, green: 0.34, blue: 0.64))
                    .cornerRadius(15)
                    .foregroundColor(.white)
                    .font(.title2.bold())
                    
                    Spacer()
                }
            }
        }
        .onAppear{
            userScore = 0
            currentRound = 0
            restart = false
            askQuestion()
        }
        .alert(alertTitle, isPresented: $isAlertShown) {
            Button("Next Round") {
                askQuestion()
            }
        } message: {
            Text(alertMessage)
        }
        .alert("You finished!", isPresented: $isGameFinished) {
            Button("Restart") {
                restart.toggle()
            }
        } message: {
            Text("You scored \(userScore)/\(questionsAmount)")
        }
        .navigationBarHidden(true)
    }
    
    func askQuestion() {
        currentQuestionNumber = Int.random(in: 2...10)
        correctAnswer = number * currentQuestionNumber
        userAnswer = ""
        isAlertShown = false
    }
    
    func answerQuestion() {
        let wasUserCorrect = String(correctAnswer) == userAnswer
        if currentRound < questionsAmount {
            if wasUserCorrect {
                alertTitle = "It's true"
                alertMessage = "You nailed it!"
                userScore += 1
            } else {
                alertTitle = "Almost"
                alertMessage = "Better luck next time!"
            }
            currentRound += 1
            isAlertShown = true
        }
        if currentRound == questionsAmount {
            isAlertShown = false
            isGameFinished = true
        }
    }
    
    func limitText(_ upper: Int) {
        if userAnswer.count > upper {
            userAnswer = String(userAnswer.prefix(upper))
        }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(number: .constant(12), questionsAmount: .constant(3))
    }
}

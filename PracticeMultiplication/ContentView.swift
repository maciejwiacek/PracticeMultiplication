//
//  ContentView.swift
//  PracticeMultiplication
//
//  Created by Maciej Wiącek on 08/09/2023.
//

import SwiftUI

struct ContentView: View {
    @State private var disabledUpButton = false
    @State private var disabledDownButton = true
    @State private var number = 2 {
        didSet {
            disabledUpButton = number >= 12
            disabledDownButton = number <= 2
        }
    }
    
    @State private var disabledButton = false
    @State private var selectedQuestionsAmount = 5
    let questionsAmount = [5, 10, 15]
    
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(red: 0.25, green: 0.16, blue: 0.39)
                    .ignoresSafeArea()
                
                VStack(spacing: 50) {
                //MARK: Number Selection
                    VStack(spacing: 20) {
                        VStack(alignment: .leading) {
                            Image("pig")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100)
                            
                            Text("What number multiply\ndo you want to learn?")
                                .foregroundColor(.white)
                                .font(.title2.bold())
                                .frame(width: 260)
                                .padding(.vertical)
                                .background(Color(red: 0.93, green: 0.62, blue: 0.93))
                                .cornerRadius(15)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 15)
                                        .inset(by: 2)
                                        .stroke(Color(red: 0.77, green: 0.35, blue: 0.77), lineWidth: 4)
                                )
                        }
                        
                        HStack(spacing: 40) {
                            Button {
                                number -= 1
                            } label: {
                                Image("-")
                            }
                            .disabled(disabledDownButton)
                            .frame(width: 70, height: 100)
                            .background(disabledDownButton ? Color(red: 0.33, green: 0.23, blue: 0.51) : Color(red: 0.45, green: 0.34, blue: 0.64))
                            .cornerRadius(15)
                            .shadow(color: .black.opacity(0.1), radius: 2, x: 0, y: 2)
                            
                            Text(String(number))
                                .foregroundColor(.white)
                                .font(.system(size: 70).bold())
                            
                            Button {
                                number += 1
                            } label: {
                                Image("+")
                            }
                            .disabled(disabledUpButton)
                            .frame(width: 70, height: 100)
                            .background(disabledUpButton ? Color(red: 0.33, green: 0.23, blue: 0.51) : Color(red: 0.45, green: 0.34, blue: 0.64))
                            .cornerRadius(15)
                            .shadow(color: .black.opacity(0.1), radius: 2, x: 0, y: 2)
                        }
                    }
                    
                    // MARK: Questions Amount
                    VStack(spacing: 20) {
                        Text("How many rounds\ndo you want to play?")
                            .foregroundColor(.white)
                            .font(.title2.bold())
                            .frame(width: 260)
                            .padding(.vertical)
                            .background(Color(red: 0.93, green: 0.62, blue: 0.93))
                            .cornerRadius(15)
                            .overlay(
                                RoundedRectangle(cornerRadius: 15)
                                    .inset(by: 2)
                                    .stroke(Color(red: 0.77, green: 0.35, blue: 0.77), lineWidth: 4)
                            )
                        
                        HStack(spacing: 30) {
                            ForEach(questionsAmount, id: \.self) { number in
                                Button {
                                    selectedQuestionsAmount = number
                                } label: {
                                    Text(String(number))
                                }
                                .disabled(selectedQuestionsAmount == number)
                                .foregroundColor(.white)
                                .font(.title.bold())
                                .frame(width: 70, height: 100)
                                .background(selectedQuestionsAmount == number ? Color(red: 0.33, green: 0.23, blue: 0.51) : Color(red: 0.45, green: 0.34, blue: 0.64))
                                .animation(.default, value: selectedQuestionsAmount == number)
                                .cornerRadius(15)
                                .shadow(color: .black.opacity(0.1), radius: 2, x: 0, y: 2)
                            }
                        }
                    }
                    
                        //MARK: Submit Button
                    NavigationLink(destination: GameView(number: $number, questionsAmount: $selectedQuestionsAmount)) {
                        Text("Let's Go!")
                            .frame(width: 260, height: 70)
                            .foregroundColor(.white)
                            .font(.title2.bold())
                            .background(Color(red: 0.45, green: 0.34, blue: 0.64))
                            .cornerRadius(15)
                    }
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

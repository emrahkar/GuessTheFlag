//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Emrah Karabulut on 5.04.2022.
//

import SwiftUI

struct ContentView: View {
    
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var score = 0
    @State private var gameOver = false
    @State private var questionNumber = 1
    
    var body: some View {
        
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.blue, .black]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            VStack {
                
                Text("Guess the flag")
                    .font(.largeTitle.weight(.bold))
                    .foregroundColor(.white)
                VStack(spacing: 15){
                    VStack{
                        Text("Tap the flag of")
                            .font(.subheadline.weight(.heavy))
                            .foregroundStyle(.secondary)
                        Text(countries[correctAnswer])
                            .foregroundColor(.white)
                            .font(.largeTitle.weight(.semibold))
                        }
                    
                    ForEach(0..<3){number in
                        Button{
                            flagTapped(number)
                        }label: {
                            Image(countries[number])
                                .renderingMode(.original)
                                .clipShape(Capsule())
                                .shadow(radius: 5)
                                
                        }
                    
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            }
        }
        .alert(scoreTitle, isPresented: $showingScore){
            Button("Continue", action:askQuestion)
        } message: {
            Text("Your score is \(score)")
                .foregroundColor(.white)
                .font(.title.bold())
        }
        
        .alert(scoreTitle, isPresented: $gameOver){
            Button("Restart Game", action: askQuestion)
        } message: {
            if score > 6{
                Text("Your score is \(score), awesome!")
            } else {
                Text("Your score is \(score)")
            }
        }
   }
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
            score += 1
        } else {
            scoreTitle = "Wrong this is the flag of \(countries[number])"
            
        }
        
        showingScore = true
    }
    
    func askQuestion() {
        
        questionNumber += 1
        
        if questionNumber < 9 {
            countries.shuffle()
            correctAnswer = Int.random(in:0...2)
            
        } else {
            gameOver = true
            questionNumber = 0
            scoreTitle = "Game over"
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


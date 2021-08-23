//
//  ContentView.swift
//  Guess the Flag
//
//  Created by Aleksey Pestov on 18.08.2021.
//

import SwiftUI

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var scoreText = ""
    @State private var score = 0
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.blue, Color.black]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            VStack(spacing: 30) {
                VStack {
                    Text("Tap the flag of")
                    Text(countries[correctAnswer])
                        .font(.largeTitle)
                        .fontWeight(.black)
                }
                ForEach(0..<3) {num in
                    Button {
                        self.flagTapped(num)
                    } label: {
                        FlagImage(image: countries[num])
                    }
                }
                Text("Score: \(score)")
                Spacer()
            }
            .foregroundColor(.white)
        }
        .alert(isPresented: $showingScore) {
            Alert(title: Text(scoreTitle),
                  message: Text(scoreText),
                  dismissButton: .default(Text("Continue")) {
                    self.askQuestion()
                  })
        }
    }
    
    func flagTapped(_ number: Int) {
        if correctAnswer == number {
            scoreTitle = "Correct"
            score += 1
            scoreText = "Your score is \(score)"
        } else {
            scoreTitle = "Wrong"
            scoreText = "That was the flag of \(countries[number])"
        }
        showingScore = true
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

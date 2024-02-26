//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by 徐文超 on 2024/2/25.
//

import SwiftUI

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var score = 0
    @State private var questionTime = 1
    
    var isOver: Bool {
        return questionTime == 3
    }
    
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3),
            ], center: .top, startRadius: 200, endRadius: 400)
            .ignoresSafeArea()
            
            VStack {
                VStack {
                    Text("Guess the Flag")
                        .font(.largeTitle.weight(.bold))
                        .foregroundStyle(.white)
                    Text(countries[correctAnswer])
                        .foregroundStyle(.white)
                        .font(.largeTitle.weight(.semibold))
                }
                ForEach(0..<3) { number in
                    Button {
                        answer(number)
                    } label: {
                        Text(countries[number]).padding(6)
                    }.background(.white).cornerRadius(4).shadow(radius: 5)                }
            }.frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
            
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            if isOver {
                Text("Your score is \(score)")
                    .foregroundColor(.white)
                    .font(.title.bold())
            }
        }
    }
    
    func askQuestion() {
        if isOver {
            score = 0
            questionTime = 1
        } else {
            questionTime += 1
        }
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
    func answer(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct!"
            score += 1
        } else {
            scoreTitle = "Wrong!That‘s \(countries[number])"
            if score > 0 {
                score -= 1
            }
        }
        
        if (isOver) {
            scoreTitle = "Over now!"
        }
        showingScore = true
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

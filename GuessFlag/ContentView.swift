//
//  ContentView.swift
//  GuessFlag
//
//  Created by Jiří Zenzinger on 08.02.2021.
//

import SwiftUI

struct ContentView: View {
    
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    
    //If status is false, then don't improve score, if true, then score will be scores + 1, in showScore() func
    @State private var scoreStatus = false
    @State private var scores = 0
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.gray, Color.init("darkGray")]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            VStack(spacing: 40) {
                VStack {
                    Text("Tap the flag of")
                        .foregroundColor(.white)
                        .padding(.top)
                    
                    Text(countries[correctAnswer])
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .font(.largeTitle)
                }
                
                ForEach(0 ..< 3) { number in
                    Button(action: {
                        self.flagTapped(number)
                        self.showScore()
                    }) {
                        Image(self.countries[number])
                            .renderingMode(.original)
                            .clipShape(Capsule())
                            .overlay(Capsule().stroke(Color.gray, lineWidth: 1))
                            .shadow(color: Color.init("darkGray"), radius: 8)
                    }
                }
                Spacer()
                
                HStack {
                    Text("Score:")
                        .foregroundColor(.white)
                    Text("\(scores)")
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                        .font(.title)
                }.padding(.bottom)
            }
        }.alert(isPresented: $showingScore) {
            Alert(title: Text(scoreTitle), message: Text("Your score is \(scores)"), dismissButton: .default(Text("Continue")){
                self.askQuestion()
            })
        }
    }
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct!"
            scoreStatus = true
        } else {
            scoreTitle = "Wrong..."
            scoreStatus = false
        }
        
        showingScore = true
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
    func showScore() {
        if scoreStatus == true {
            scores += 1
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

//
//  ContentView.swift
//  RockPaperScissorsGame
//
//  Created by Zach Becker on 12/26/23.
//

/*
 So, very roughly:

 Each turn of the game the app will randomly pick either rock, paper, or scissors.
 Each turn the app will alternate between prompting the player to win or lose.
 The player must then tap the correct move to win or lose the game.
 If they are correct they score a point; otherwise they lose a point.
 The game ends after 10 questions, at which point their score is shown.
 So, if the app chose “Rock” and “Win” the player would need to choose “Paper”, but if the app chose “Rock” and “Lose” the player would need to choose “Scissors”.
 */

import SwiftUI

struct ContentView: View {
    @State private var gameElements = ["Rock", "Paper", "Scissors"]
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var successCriteria = ["Win", "Lose"]
    @State private var score = 0
    @State private var gameCount = 0
    
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.3), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.4, blue: 0.4), location: 0.3)
            ], center: .bottom, startRadius: .pi, endRadius: 500)
            .ignoresSafeArea()
            
            VStack {
                Text("Rock, Paper, Scissors")
                    .foregroundStyle(.white)
                    .fontWeight(.semibold)
                Spacer()
            }
            
            VStack {
                Spacer()
                Spacer()
                Text("Score")
                    .foregroundStyle(.white)
                    .font(.largeTitle)
                Text("\(score)")
                    .foregroundStyle(.white)
                    .font(.largeTitle)
            }
        }
    }
}

#Preview {
    ContentView()
}

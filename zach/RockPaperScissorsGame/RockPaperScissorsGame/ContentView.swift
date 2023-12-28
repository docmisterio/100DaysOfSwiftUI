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

public extension UIFont {
    static func textStyleSize(_ style: UIFont.TextStyle) -> CGFloat {
        UIFont.preferredFont(forTextStyle: style).pointSize
    }
}

struct ContentView: View {
    @State private var gameElements = ["🪨", "📃", "✂️"]
    @State private var gameChoice = Int.random(in: 0...2)
    @State private var successCriteria = ["Win", "Lose"].shuffled()
    @State private var successChoice = Int.random(in: 0...1)
    @State private var scoreTitle = ""
    @State private var score = 0
    @State private var gameCount = 0
    
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.3), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.4, blue: 0.4), location: 0.3)
            ], center: .bottom, startRadius: 300, endRadius: 500)
            .ignoresSafeArea()
            
            VStack {
                Text("Rock, Paper, Scissors")
                    .padding(40)
                    .font(.largeTitle)
                    .foregroundStyle(.thickMaterial)
                Text(gameElements[gameChoice])
                    .frame(maxWidth: 350)
                    .shadow(radius: 15)
                    .padding(.vertical, 15)
                    .background(.ultraThinMaterial)
                    .clipShape(.capsule)
                Spacer()
                Spacer()
                Text(successCriteria[successChoice])
                    .frame(maxWidth: 350)
                    .shadow(radius: 15)
                    .padding(.vertical, 15)
                    .background(.ultraThinMaterial)
                    .clipShape(.capsule)
                
                VStack {
                    Image(systemName: "arrow.down")
                        .font(.system(size: 100))
                        .padding(.vertical, 50)
                        .scaledToFit()
                        .foregroundStyle(.ultraThinMaterial)
                }
                
                VStack(spacing: 45) {
                    Text("Choose your player")
                        .font(.headline.bold())
                        .foregroundStyle(.white)

                    HStack(spacing: 15) {
                        ForEach(0..<3) { number in
                            Button {
                                buttonTapped(number)
                            } label: {
                                Text(gameElements[number])
                                    .font(.system(size: UIFont.textStyleSize(.largeTitle) * 2))
                                    .shadow(radius: 20)

                            }
                        }
                    }
                    .frame(maxWidth: 350)
                    .shadow(radius: 15)
                    .padding(.vertical, 15)
                    .background(.ultraThinMaterial)
                    .clipShape(.capsule)
                    Spacer()
                }
            }
        }
    }
    
    enum gameModes {
        case win
        case lose
    }
    
    func buttonTapped(_ answerTapped: Int) {
        let userChoice = answerTapped
        
        if userChoice == gameChoice {
            // tie
        } else if (userChoice == 0 && gameChoice == 2) ||
                    (userChoice == 2 && gameChoice == 1) ||
                    (userChoice == 1 && gameChoice == 0) {
            // user wins
        } else {
            // computer wins
        }
    }
}

#Preview {
    ContentView()
}

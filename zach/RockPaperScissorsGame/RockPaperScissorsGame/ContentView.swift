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

enum RockPaperScissors: String, CaseIterable {
    case rock = "🪨"
    case paper = "📃"
    case scissors = "✂️"
}

enum SuccessCriteria: String, CaseIterable {
    case win = "Win"
    case lose = "Lose"
}

struct ContentView: View {
    @State private var gameElements: [RockPaperScissors] = RockPaperScissors.allCases
    @State private var gameChoice: RockPaperScissors = RockPaperScissors.allCases.randomElement() ?? .rock
    @State private var winOrLose: [SuccessCriteria] = SuccessCriteria.allCases
    @State private var successChoice = SuccessCriteria.allCases.randomElement() ?? .win
    @State private var scoreTitle = ""
    @State private var score = 0
    @State private var gameCount = 0
    @State private var showingScore = false
    @State private var finalAlert = false
    
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
                Text(gameChoice.rawValue)
                    .frame(maxWidth: 350)
                    .shadow(radius: 15)
                    .padding(.vertical, 15)
                    .background(.ultraThinMaterial)
                    .clipShape(.capsule)
                Spacer()
                Spacer()
                Text(successChoice.rawValue)
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
                        ForEach(RockPaperScissors.allCases, id: \.self) { choice in
                            Button {
                                buttonTapped(choice)
                            } label: {
                                Text(choice.rawValue)
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
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: loadRound)
        } message: {
            Text("Your Score is \(score).")
        }
        .alert(scoreTitle, isPresented: $finalAlert) {
            Button("Restart", role: .destructive, action: restartGame)
        } message: {
            if score <= 5 {
                Text("A score of \(score) is pathetic. \n Go read a book.")
            } else {
                Text("\(score) is a good score! Kudos.")
            }
        }
    }
    
    
    func winScenario() {
        scoreTitle = "Correct"
        gameCount += 1
        score += 1
    }
    
    func loseScenario() {
        scoreTitle = "Wrong"
        gameCount += 1
        score -= 1
    }
    
    func tieScenario() {
        scoreTitle = "Tie"
        gameCount += 1
    }
    
    func loadRound() {
        gameChoice = RockPaperScissors.allCases.randomElement() ?? .rock
        successChoice = SuccessCriteria.allCases.randomElement() ?? .win
    }
    
    func restartGame() {
        gameCount = 0
        loadRound()
    }
    
    func buttonTapped(_ answerTapped: RockPaperScissors) {
        let userChoice = answerTapped
        
        switch successChoice {
        case .win:
            if userChoice == gameChoice {
                tieScenario()
            } else if (gameChoice == .rock && userChoice == .scissors) ||
                        (gameChoice == .paper && userChoice == .rock) ||
                        (gameChoice == .scissors && userChoice == .paper) {
                winScenario()
            } else {
                loseScenario()
            }
            showingScore = true
        case .lose:
            if userChoice == gameChoice {
                tieScenario()
            } else if (gameChoice == .rock && userChoice == .paper) ||
                        (gameChoice == .paper && userChoice == .scissors) ||
                        (gameChoice == .scissors && userChoice == .rock) {
                winScenario()
            } else {
                loseScenario()
            }
            showingScore = true
        }
    }
}

#Preview {
    ContentView()
}

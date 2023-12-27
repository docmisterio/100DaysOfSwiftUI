/*
 One of the best ways to learn is to write your own code as often as possible, so here are three ways you should try extending this app to make sure you fully understand what’s going on:

  DONE - Add an @State property to store the user’s score, modify it when they get an answer right or wrong, then display it in the alert and in the score label.
 DONE - When someone chooses the wrong flag, tell them their mistake in your alert message – something like “Wrong! That’s the flag of France,” for example.
 DONE - Make the game show only 8 questions, at which point they see a final alert judging their score and can restart the game.
 
 DONE - Challenge from day 24 - Go back to project 2 and replace the Image view used for flags with a new FlagImage() view that renders one flag image using the specific set of modifiers we had.
 
 */
import SwiftUI

struct FlagImage: ViewModifier {
    func body(content: Content) -> some View {
        content
            .clipShape(.capsule)
            .shadow(radius: 5)
    }
}

extension View {
    func styledFlag() -> some View {
        modifier(FlagImage())
    }
}

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var showingScore = false
    @State private var finalAlert = false
    @State private var scoreTitle = ""
    @State private var score = 0
    @State private var gameCount = 0
    
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3)
            ], center: .top, startRadius: 200, endRadius: 700)
            .ignoresSafeArea()
            
            VStack {
                Spacer()
                
                Text("Guess The Flag")
                    .font(.largeTitle.bold())
                    .foregroundStyle(.white)
                
                VStack(spacing: 15) {
                    VStack {
                        Text("Tap the flag of")
                            .foregroundStyle(.white)
                            .font(.subheadline.weight(.heavy))
                        Text(countries[correctAnswer])
                            .foregroundStyle(.white)
                            .font(.largeTitle.weight(.semibold))
                    }
                    
                    ForEach(0..<3) { number in
                        Button {
                            flagTapped(number)
                        } label: {
                            Image(countries[number])
                                .styledFlag()
                        }
                    }
                }
                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(.rect(cornerRadius: 20))
                
                Spacer()
                Spacer()
                
                Text ("Score: \(score)")
                    .foregroundStyle (.white)
                    .font(.title.bold())
                
                Spacer()
            }
            .padding()
            
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
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
    
    func flagTapped(_ number: Int) {
        if gameCount != 8 {
            if number == correctAnswer {
                scoreTitle = "Correct"
                score += 1
                gameCount += 1
            } else {
                scoreTitle = "Wrong. \n That's the flag of \(countries[number])"
                gameCount += 1
            }
            showingScore = true
        } else {
            scoreTitle = "Game Over!"
            finalAlert = true
        }
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
    func restartGame() {
        gameCount = 0
        askQuestion()
    }
}

#Preview {
    ContentView()
}

//
//  ContentView.swift
//  WordScramble
//
//  Created by Zach Becker on 1/7/24.
//

import SwiftUI

struct ContentView: View {
    @State private var usedWords = [String]()
    @State private var rootWord = ""
    @State private var newWord = ""
    
    @State private var errorMessage = ""
    @State private var errorTitle = ""
    @State private var showingAlert = false
    
    @State private var scale = false
    @State private var score = 0
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    TextField("Enter Your Word", text: $newWord)
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled()
                }
                
                Section {
                    ForEach(usedWords, id: \.self) { word in
                        HStack {
                            Image(systemName: "\(word.count).circle.fill")
                                .scaleEffect(scale ? 1 : 2.2)
                                .onAppear() {
                                    withAnimation {
                                        scale.toggle()
                                    }
                                }
                            Text(word)
                        }
                    }
                }
            }
            .navigationTitle(rootWord)
            .toolbar {
                ToolbarItem {
                    Button("refresh", action: startGame)
                }
            }
            .onSubmit(addNewWord)
            .onAppear(perform: startGame)
            .alert(errorTitle, isPresented: $showingAlert) { } message: {
                Text(errorMessage)
            }
        }
        Text("score: \(score)")
            .font(.title)
    }
    
    func addNewWord() {
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        guard answer.count > 0 else { return }
                
        guard isOriginal(word: answer) else {
            wordError(title: "Word Used Already", message: "Be more original.")
            return
        }
        
        guard isPossible(word: answer) else {
            wordError(title: "Word Not Possible", message: "You can't spell that word with \(rootWord)!")
            return
        }
        
        guard isReal(word: answer) else {
            wordError(title: "Word Not Recognized", message: "You can't just make shit up!")
            return
        }
        
        guard isLongerThanThree(word: answer) else {
            wordError(title: "Word Too Short", message: "I see you trying to game the system.")
            return
        }
        
        guard isRootWord(word: answer) else {
            wordError(title: "Whole Word Error", message: "\(rootWord) can't be used as a word.")
            return
        }
        
        if isReal(word: answer) && isPossible(word: answer) && isRootWord(word: answer) && isOriginal(word: answer) && isLongerThanThree(word: answer) == true {
            addScore(wordCount: answer.count)
        }
    
        withAnimation {
            usedWords.insert(answer, at: 0)
            scale = false
        }
        newWord = ""
    }
    
    func startGame() {
        usedWords.removeAll()
        score = 0

        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            if let startWords = try? String(contentsOf: startWordsURL) {
                let allWords = startWords.components (separatedBy: "\n")
                rootWord = allWords.randomElement() ?? "silkworm"
                return
            }
        }
        
        fatalError("Could not load start.txt from bundle.")
    }
    
    func isOriginal(word: String) -> Bool {
        !usedWords.contains(word)
    }
    
    func isPossible(word: String) -> Bool {
        var tempWord = rootWord
        
        for letter in word {
            if let pos = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: pos)
            } else {
                return false
            }
        }
        return true
    }
    
    func isReal(word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let missspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        
        return missspelledRange.location == NSNotFound
    }
    
    func isLongerThanThree(word: String) -> Bool {
        if word.count <= 3 {
            false
        } else {
            true
        }
    }
    
    func isRootWord(word: String) -> Bool {
        if word == rootWord {
            false
        } else {
            true
        }
    }
    
    func addScore(wordCount: Int) {
        score += wordCount
    }

    func wordError(title: String, message: String) {
        errorTitle = title
        errorMessage = message
        showingAlert = true
    }
}

#Preview {
    ContentView()
}

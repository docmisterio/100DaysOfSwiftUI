//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Zach Becker on 12/18/23.
//

import SwiftUI

struct ContentView: View {
    @State private var showingAlert = false
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [.red, .blue], startPoint: .top, endPoint: .bottom)
            
            VStack {
                Button("ALERT", systemImage: "exclamationmark.triangle") {
                    showingAlert = true
                }
                .alert("Lookeeee", isPresented: $showingAlert) {
                    Button("OK") { }
                }
                .font(.largeTitle)
                .foregroundStyle(.black)
                Button {
                    print("my content was tapped")
                    
                } label: {
                    Label("My Content", systemImage: "arrowshape.down")
                }
                .padding()
                .foregroundStyle(.primary)
                .fontWeight(.bold)
                .font(.largeTitle)
            }
            
        }
        .ignoresSafeArea()
    }
}

#Preview {
    ContentView()
}

//
//  ContentView.swift
//  Animations
//
//  Created by Zach Becker on 1/21/24.
//

import SwiftUI

struct ContentView: View {
    @State private var animationAmount = 1.0
    
    var body: some View {
        Button("Tap Me") {
//            animationAmount += 1
        }
        .padding(50)
        .background(.red)
        .foregroundStyle(.white)
        .clipShape(.circle)
        .overlay(
            Circle()
                .stroke(.red)
                .scaleEffect(animationAmount)
                .opacity(2 - animationAmount)
                .animation(
                    .easeInOut(duration: 1)
                        .repeatForever(autoreverses: false)
                    , value: animationAmount
                )
        )
        .onAppear {
            animationAmount = 2
        }
        

        
    }
}

#Preview {
    ContentView()
}

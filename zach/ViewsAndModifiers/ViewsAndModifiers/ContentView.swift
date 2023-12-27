//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by Zach Becker on 12/26/23.
//
// Create a custom ViewModifier (and accompanying View extension) that makes a view have a large, blue font suitable for prominent titles in a view.

import SwiftUI

struct AlterText: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundStyle(.blue)
    }
}

extension View {
    func alteredText() -> some View {
        modifier(AlterText())
    }
}

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
                .alteredText()
        }
        .padding()
    }
}

#Preview {
    ContentView()
}

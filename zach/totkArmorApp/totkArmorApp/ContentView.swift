//
//  ContentView.swift
//  totkArmorApp
//
//  Created by Zach Becker on 1/10/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            List {
                ForEach(0..<36) {
                    Text("Armor Set \($0)")
                }
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}

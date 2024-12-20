//
//  TagView.swift
//  DewToDo
//
//  Created by Zach Becker on 12/11/24.
//

import SwiftUI

struct TagView: View {
    let tag: String
    let isSelected: Bool
    let action: () -> Void
    var backgroundColor: Color = .gray.opacity(0.3)
    var selectedColor: Color = .blue

    var body: some View {
        Text(tag)
            .font(.body)
            .padding()
            .background(isSelected ? selectedColor : backgroundColor)
            .foregroundColor(isSelected ? .white : .black)
            .cornerRadius(10)
            .onTapGesture {
                action()
            }
    }
}

struct TagView_Previews: PreviewProvider {
    static var previews: some View {
        TagView(tag: "Buy", isSelected: false, action: {})
    }
}


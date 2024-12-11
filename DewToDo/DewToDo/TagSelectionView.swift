//
//  TagSelectionView.swift
//  DewToDo
//
//  Created by Zach Becker on 12/11/24.
//

import SwiftUI

struct TagSelectionView: View {
    @State private var tags = ["Buy", "Plant", "Harvest", "Sell", "Water"]
    @State private var selectedTags: [String] = []

    let columns = [
        GridItem(.adaptive(minimum: 100, maximum: 150), spacing: 10)
    ]

    var body: some View {
        VStack {
            Text("Select a Tag")
                .font(.title)
                .padding()

            ScrollView {
                LazyVGrid(columns: columns, spacing: 10) {
                    ForEach(tags, id: \.self) { tag in
                        TagView(tag: tag, isSelected: selectedTags.contains(tag)) {
                            if selectedTags.contains(tag) {
                                selectedTags.removeAll { $0 == tag }
                            } else {
                                selectedTags.append(tag)
                            }
                        }
                    }
                }
                .padding()
            }

            if !selectedTags.isEmpty {
                Text("Selected: \(selectedTags.joined(separator: ", "))")
                    .padding()
                    .font(.headline)
            }
        }
    }
}

struct TagView: View {
    let tag: String
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Text(tag)
            .font(.body)
            .padding()
            .background(isSelected ? Color.blue : Color.gray.opacity(0.3))
            .foregroundColor(isSelected ? .white : .black)
            .cornerRadius(10)
            .onTapGesture {
                action()
            }
    }
}

struct TagSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        TagSelectionView()
    }
}


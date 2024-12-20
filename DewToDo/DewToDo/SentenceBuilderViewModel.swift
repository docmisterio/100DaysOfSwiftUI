//
//  SentenceBuilderViewModel.swift
//  DewToDo
//
//  Created by Zach Becker on 12/11/24.
//

import SwiftUI

class SentenceBuilderViewModel: ObservableObject {
    @Published var tags = ["Buy", "Plant", "Harvest", "Sell", "Water", "From Pierre", "From Sandy"]
    @Published var selectedTags: [String] = []
    @Published var filteredTags: [String] = []

    init() {
        updateFilteredTags()
    }

    func selectTag(_ tag: String) {
        if selectedTags.contains(tag) {
            selectedTags.removeAll { $0 == tag }
        } else {
            selectedTags.append(tag)
        }
        updateFilteredTags()
    }

    func addCustomInput(_ input: String) {
        if !input.isEmpty {
            selectedTags.append(input)
            updateFilteredTags()
        }
    }

    private func updateFilteredTags() {
        filteredTags = tags.filter { !selectedTags.contains($0) }
    }
}


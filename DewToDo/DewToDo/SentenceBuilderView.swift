//
//  SentenceBuilderView.swift
//  DewToDo
//
//  Created by Zach Becker on 12/11/24.
//

import SwiftUI

struct SentenceBuilderView: View {
    @StateObject private var viewModel = SentenceBuilderViewModel()
    @State private var currentInput: String = ""

    let columns = [
        GridItem(.adaptive(minimum: 100, maximum: 150), spacing: 10)
    ]

    var body: some View {
        VStack {
            // Sentence Bar
            HStack {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 10) {
                        ForEach(viewModel.selectedTags, id: \.self) { tag in
                            Text(tag)
                                .padding(8)
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(5)
                        }
                    }
                }
                .frame(height: 50)
                .padding(.horizontal)

                // Custom Input Field
                TextField("Type here...", text: $currentInput, onCommit: {
                    viewModel.addCustomInput(currentInput)
                    currentInput = ""
                })
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .frame(width: 150)
            }
            .padding(.vertical)

            Divider()

            // Tag Selection
            Text("Select a Tag")
                .font(.title)
                .padding()

            ScrollView {
                LazyVGrid(columns: columns, spacing: 10) {
                    ForEach(viewModel.filteredTags, id: \.self) { tag in
                        TagView(tag: tag, isSelected: viewModel.selectedTags.contains(tag)) {
                            viewModel.selectTag(tag)
                        }
                    }
                }
                .padding()
            }
        }
    }
}

struct SentenceBuilderView_Previews: PreviewProvider {
    static var previews: some View {
        SentenceBuilderView()
    }
}


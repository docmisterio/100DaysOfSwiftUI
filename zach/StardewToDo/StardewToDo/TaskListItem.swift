//
//  TaskListItem.swift
//  StardewToDo
//
//  Created by Zach Becker on 12/1/24.
//

import Foundation
import SwiftUI

struct TaskListItem: View {
    @Binding var task: Task
    var onComplete: () -> Void

    var body: some View {
        HStack {
            Text(task.title)
                .strikethrough(task.isCompleted)
            Spacer()
            if task.isCompleted {
                Image(systemName: "checkmark.circle.fill")
                    .foregroundColor(.green)
            } else {
                Button(action: {
                    onComplete()
                }) {
                    Image(systemName: "circle")
                }
                .buttonStyle(BorderlessButtonStyle())
            }
        }
    }
}


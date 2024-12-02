//
//  ContentView.swift
//  StardewToDo
//
//  Created by Zach Becker on 12/1/24.
//

import SwiftUI

struct TaskListView: View {
    // State for tasks
    @State private var tasks = [
        Task(id: 1, title: "Water the plants", isCompleted: false),
        Task(id: 2, title: "Read a book for 30 minutes", isCompleted: false),
        Task(id: 3, title: "Go for a walk", isCompleted: false)
    ]
    
    @State private var xp: Int = 0 // State for XP

    var body: some View {
        NavigationView {
            VStack {
                // XP Progress Bar
                VStack {
                    Text("XP: \(xp)")
                        .font(.headline)
                        .padding(.bottom, 4)
                    ProgressView(value: Double(xp), total: 100)
                        .progressViewStyle(LinearProgressViewStyle(tint: .green))
                        .padding(.horizontal)
                }
                .padding()

                // Task List
                    List {
                        ForEach($tasks) { $task in
                            TaskListItem(task: $task) {
                                withAnimation {
                                    if let index = tasks.firstIndex(where: { $0.id == task.id }) {
                                        tasks.remove(at: index)
                                        xp += 10
                                    }
                                }
                            }
                        }
                    }

                .listStyle(InsetGroupedListStyle())
            }
            .navigationTitle("Your Tasks")
        }
    }

    private func completeTask(_ task: Task) {
        if let index = tasks.firstIndex(where: { $0.id == task.id }) {
            tasks[index].isCompleted = true
            xp += 10 // Add XP for completing a task
        }
    }
}

// Task Model
struct Task: Identifiable {
    let id: Int // Conforming to Identifiable requires a unique id
    var title: String
    var isCompleted: Bool
}

// Preview
struct TaskListView_Previews: PreviewProvider {
    static var previews: some View {
        TaskListView() // Standalone preview-friendly view
    }
}

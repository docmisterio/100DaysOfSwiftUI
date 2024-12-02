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
        Task(id: 1, title: "Buy Seeds From Pierre", isCompleted: false),
        Task(id: 2, title: "Give Emily a Jade", isCompleted: false),
        Task(id: 3, title: "Upgrade to Steel Axe", isCompleted: false)
    ]
    
    @State private var xp: Int = 0 // State for XP
    @State private var showCompleted = false // Toggle for completed tasks
    @State private var newTaskTitle: String = ""
    
    
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
                        .autocorrectionDisabled()
                        .keyboardType(.default)
                }
                .padding()
                
                // Input Field and Add Button
                HStack {
                    TextField("What do you need to do?", text: $newTaskTitle)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal)
                    
                    Button(action: addTask) {
                        Image(systemName: "plus.circle.fill")
                            .font(.title)
                            .foregroundColor(.green)
                    }
                    .padding(.trailing)
                    .disabled(newTaskTitle.trimmingCharacters(in: .whitespaces).isEmpty) // Disable when empty
                }
                .padding(.vertical)
                
                // Toggle to show/hide completed tasks
                Toggle("Show Completed Tasks", isOn: $showCompleted)
                    .padding()
                
                // Task List
                List {
                    ForEach(filteredTasks) { $task in
                        TaskListItem(task: $task) {
                            withAnimation {
                                toggleTaskCompletion(task)
                            }
                        }
                    }
                }
                .listStyle(InsetGroupedListStyle())
            }
            .navigationTitle("Your Tasks")
        }
    }
    
    // MARK: - Computed Property: Filtered Tasks
    private var filteredTasks: [Binding<Task>] {
        tasks.filter { task in
            showCompleted || !task.isCompleted // Plain property access
        }
        .compactMap { task in
            $tasks.first { $0.id == task.id } // Convert back to bindings
        }
    }
    
    // MARK: - Function: Toggle Task Completion
    private func toggleTaskCompletion(_ task: Task) {
        if let index = tasks.firstIndex(where: { $0.id == task.id }) {
            tasks[index].isCompleted.toggle()
            xp += tasks[index].isCompleted ? 10 : -10 // Adjust XP
        }
    }
    // MARK: - Function: Add Task
    private func addTask() {
        let trimmedTitle = newTaskTitle.trimmingCharacters(in: .whitespaces)
        guard !trimmedTitle.isEmpty else { return } // Prevent Empty Tasks
        
        withAnimation {
            let newTask = Task(id: tasks.count + 1, title: trimmedTitle, isCompleted: false)
            tasks.append(newTask)
        }
        newTaskTitle = "" // Clears input after adding
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

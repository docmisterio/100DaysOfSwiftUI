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
        Task(id: 2, title: "Gift Emily a Jade", isCompleted: false),
        Task(id: 3, title: "Upgrade to Steel Axe", isCompleted: false)
    ]
    
    @State private var xp: Int = 0 // State for XP
    @State private var showCompleted = false // Toggle for completed tasks
    @State private var newTaskTitle: String = ""
    @State private var filteredSuggestions: [String] = [] // Dynamic suggestions
    
    // MARK: - Constants
    let taskSuggestions: [String] = [
        "Talk", "Gift", "Propose", "Marry", "Divorce", "Adopt", "Plant", "Water", "Harvest",
        "Fertilize", "Till", "Hoe", "Chop", "Tap", "Milk", "Shear", "Collect", "Enter", "Break",
        "Mine", "Fight", "Use", "Forge", "Enchant", "Smelt", "Fish", "Catch", "Pick", "Cook",
        "Eat", "Drink", "Purchase", "Sell", "Check", "Donate", "Trade", "Craft", "Decorate",
        "Place", "Rearrange", "Change", "Ride", "Warp", "Sleep", "Save", "Repair", "Interact",
        "Participate", "Submit", "Watch", "Buy"
    ]
    
    
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
                        .autocorrectionDisabled()
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal)
                        .onChange(of: newTaskTitle) { newValue, oldValue in
                            updateSuggestions(for: newValue)
                        }
                    
                    Button(action: addTask) {
                        Image(systemName: "plus.circle.fill")
                            .font(.title)
                            .foregroundColor(.green)
                    }
                    .padding(.trailing)
                    .disabled(newTaskTitle.trimmingCharacters(in: .whitespaces).isEmpty) // Disable when empty
                }
                .padding(.vertical)
                
                //Suggestions
                if !filteredSuggestions.isEmpty {
                    Group {
                        VStack {
                            ForEach(filteredSuggestions, id: \.self) { suggestion in
                                Button(action: {
                                    newTaskTitle = suggestion // Autofill Textfield
                                    filteredSuggestions = [] // Hide Suggestions
                                }) {
                                    Text(suggestion)
                                        .padding(.vertical, 4)
                                        .padding(.horizontal)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .background(Color(.systemGray6))
                                        .cornerRadius(8)
                                }
                            }
                        }
                        .padding(.horizontal)
                        .zIndex(1)
                        .transition(.opacity)
                    }
                    .animation(.easeInOut(duration: 0.3), value: filteredSuggestions)
                }
                
                // Toggle to show/hide completed tasks
                Toggle("Show Completed Tasks", isOn: $showCompleted)
                    .padding()
                
                // Task List
                List {
                    ForEach(filteredTasks) { $task in
                        TaskListItem(task: $task) {
                            toggleTaskCompletion(task)
                        }
                        .transition(.opacity)
                    }
                }
                .listStyle(InsetGroupedListStyle())
                .animation(.easeInOut(duration: 0.3), value: filteredTasks)
            }
            .navigationTitle("StardewToDo")
        }
    }
    
    // MARK: - Computed Property: Filtered Tasks
    private var filteredTasks: [Binding<Task>] {
        if showCompleted {
            return $tasks.filter { $0.wrappedValue.isCompleted }
        } else {
            return $tasks.filter { !$0.wrappedValue.isCompleted }
        }
    }
    
    // MARK: - Function: Toggle Task Completion
    private func toggleTaskCompletion(_ task: Task) {
        if let index = tasks.firstIndex(where: { $0.id == task.id }) {
            withAnimation {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    tasks[index].isCompleted.toggle()
                }
            }
            xp += tasks[index].isCompleted ? 10 : -10
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
        filteredSuggestions = [] // Clears suggestions
    }
    
    // MARK: - Function: Update Suggestions
    private func updateSuggestions(for input: String) {
        if input.isEmpty {
            filteredSuggestions = [] // Clears suggestions if input is empty
        } else if input.count < 2 {
            filteredSuggestions = []  // No suggestions for inputs equal to or at 2 chars
        } else {
            filteredSuggestions = taskSuggestions.filter { suggestion in
                suggestion.localizedCaseInsensitiveContains(input)
            }
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

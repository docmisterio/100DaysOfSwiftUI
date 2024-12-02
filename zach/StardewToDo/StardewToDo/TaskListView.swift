//
//  ContentView.swift
//  StardewToDo
//
//  Created by Zach Becker on 12/1/24.
//

import SwiftUI

struct TaskListItem: View {
    var taskName: String
    var iconName: String
    var onComplete: () -> Void
    
    var body: some View {
        HStack(spacing: 12) {
            // Task Icon
            Image(iconName)
                .resizable()
                .frame(width: 40, height: 40)
                .clipShape(RoundedRectangle(cornerRadius: 8))
            
            // Task Name
            Text(taskName)
                .font(.custom("PixelFont", size: 16)) // Replace "PixelFont" with a font similar to Stardew's style
                .foregroundColor(Color.black)
            
            Spacer()
            
            // Complete Button
            Button(action: onComplete) {
                Text("Mark Complete")
                    .font(.system(size: 14, weight: .semibold))
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(5)
            }
        }
        .padding()
        .background(Color(UIColor(red: 240/255, green: 220/255, blue: 200/255, alpha: 1)))
        .cornerRadius(8)
        .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
    }
}

struct TaskListItem_Previews: PreviewProvider {
    static var previews: some View {
        TaskListItem(
            taskName: "Plant Cauliflower",
            iconName: "task-icon-placeholder",
            onComplete: {
                print("Task Completed!")
            }
        )
        .previewLayout(.sizeThatFits)
    }
}

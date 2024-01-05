//
//  ContentView.swift
//  BetterRest
//
//  Created by Zach Becker on 1/2/24.
//

import CoreML
import SwiftUI

struct ContentView: View {
    @State private var sleepAmount = 8.0
    @State private var wakeUp = defaultWakeTime
    @State private var coffeeAmount = 1
    
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showingAlert = false
    
    static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? .now
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section("When do you want to wake up?") {
                    DatePicker("Please enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute)
                        .labelsHidden()
                }
                
                Section("Desired amount of sleep") {
                    Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4...12, step: 0.25)
                }
                
                Section("Daily Coffee Intake") {
                    Picker("^[\(coffeeAmount) cup](inflect: true)", selection: $coffeeAmount) {
                        ForEach(1...20, id: \.self) { cup in
                                Text("\(cup)")
                        }
                    }
                }
                
                Section("Go to bed by:") {
                    Text("\(calculateBedtime())")
                        .font(.largeTitle)
                }
            }
            .navigationTitle("BetterRest")
        }
    }
    
    func calculateBedtime() -> String {
        do {
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)
            
            let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
            let hour = (components.hour ?? 0) * 60 * 60
            let minute = (components.minute ?? 0) * 60
            
            let prediction = try model.prediction(wake: Int64(Double(hour + minute)),
                                                  estimatedSleep: sleepAmount, coffee: Int64(Double(coffeeAmount)))
            
            let guess = wakeUp - prediction.actualSleep
            
            let dateFormatter = DateFormatter()
            dateFormatter.timeStyle = .short
            
            let wakeTimeString = dateFormatter.string(from: guess)

            return wakeTimeString
                                
        } catch {
            return "Error"
        }
    }
}

#Preview {
    ContentView()
}

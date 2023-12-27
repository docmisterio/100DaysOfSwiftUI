//
//  ContentView.swift
//  WeSplit
//
//  Created by Zach Becker on 12/12/23.
//
// Challenge from day 23: Go back to project 1 and use a conditional modifier to change the total amount text view to red if the user selects a 0% tip.

import SwiftUI

struct ContentView: View {
    @State private var checkAmount: Double?
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    @State private var tipIsZero = false
    @FocusState private var amountIsFocused: Bool
    
    let tipPercentages = 0..<101
    
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentage)
        
        guard let checkAmount = checkAmount else { return 0 }
        
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = (checkAmount) + tipValue
        let amountPerPerson = grandTotal / peopleCount
        
        return amountPerPerson
    }
    
    var totalBeforeSplit: Double {
        let tipSelection = Double(tipPercentage)
        
        guard let checkAmount = checkAmount else { return 0 }
        
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = (checkAmount) + tipValue
        
        return grandTotal
    }
    
    var textColorIfTipIsZero: Color {
        return tipPercentage == 0 ? .red : .black
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    
                    Picker("Number of People", selection: $numberOfPeople) {
                        ForEach(2..<100) {
                            Text("\($0) people")
                        }
                    }
                }
                
                Section("How much do you want to tip?") {
                    
                    Picker("Tip Percentage", selection: $tipPercentage) {
                        ForEach(tipPercentages, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.navigationLink)
                    
                }
                
                Section("Tip Amount + Tip before Split: ") {
                    Text(totalBeforeSplit, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .foregroundStyle(textColorIfTipIsZero)
                }
                
                Section("Amount Per Person") {
                    Text(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                }
            }
            .navigationTitle("WeSplit")
            .toolbar {
                if amountIsFocused {
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}

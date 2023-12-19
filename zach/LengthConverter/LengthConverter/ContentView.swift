//
//  ContentView.swift
//  LengthConversion
//
//  Created by Zach Becker on 12/14/23.
//

import SwiftUI

enum LengthUnit: String, CaseIterable {
    case m
    case km
    case ft
    case yd
    case mi
}

func convert(value: Double, fromUnit: LengthUnit, toUnit: LengthUnit) -> Double {
    var result: Double = 0.0
    
    switch fromUnit {
    case .m:
        switch toUnit {
        case .m: result = value
        case .km: result = value / 1000.0
        case .ft: result = value * 3.28084
        case .yd: result = value * 1.09361
        case .mi: result = value * 0.000621371
        }
        
    case .km:
        switch toUnit {
        case .m: result = value * 1000.0
        case .km: result = value
        case .ft: result = value * 3280.84
        case .yd: result = value * 1093.61
        case .mi: result = value * 0.621371
        }
        
    case .ft:
        switch toUnit {
        case .m: result = value / 3.28084
        case .km: result = value / 3280.84
        case .ft: result = value
        case .yd: result = value / 3.0
        case .mi: result = value / 5280.0
        }
        
    case .yd:
        switch toUnit {
        case .m: result = value / 1.09361
        case .km: result = value / 1093.61
        case .ft: result = value * 3.0
        case .yd: result = value
        case .mi: result = value / 1760.0
        }
        
    case .mi:
        switch toUnit {
        case .m: result = value / 0.000621371
        case .km: result = value / 0.621371
        case .ft: result = value * 5280.0
        case .yd: result = value * 1760.0
        case .mi: result = value
        }
    }
    return result
}

struct ContentView: View {
    @State private var userInput: Double?
    @State private var unitOutput: Double?
    @State var inputSelection: LengthUnit = .m
    @State var outputSelection: LengthUnit = .m
    
    @FocusState private var numberIsFocused: Bool
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Input Unit") {
                    TextField("Input a value to convert", value: $userInput, format: .number)
                        .keyboardType(.decimalPad)
                        .focused($numberIsFocused)
                    
                    Picker("Unit Input", selection: $inputSelection) {
                        ForEach(LengthUnit.allCases, id: \.self) { unit in
                            Text(unit.rawValue)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                Section("Output Unit") {
                    Picker("Unit Input", selection: $outputSelection) {
                        ForEach(LengthUnit.allCases, id: \.self) { unit in
                            Text(unit.rawValue)
                        }
                    }
                    .pickerStyle(.segmented)
                    Text(String(convert(value: userInput ?? 0.0, fromUnit: inputSelection, toUnit: outputSelection)))
                }
            }
            .navigationTitle("Unit Conversion")
            .toolbar {
                if numberIsFocused {
                    Button("Done") {
                        numberIsFocused = false
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}

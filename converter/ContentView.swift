//
//  ContentView.swift
//  converter
//
//  Created by Carlos Vinicius on 29/08/22.
//

import SwiftUI

struct ContentView: View {
    @FocusState private var amountIsFocused: Bool
    @State private var inputNumber = 10.0
    @State private var inputUnit = "Meters"
    @State private var outputUnit = "Meters"
    let unitsOfLength = ["Meters", "Kilometers", "Yards", "Miles", "Feet"]
    
    var result: Double {
        
        let value = Double(inputNumber)
        
        var inputAsFeet: Double
        var output: Double
        
        guard value > 0 else {
            return 0
        }

        switch inputUnit {
        case "Meters":
            inputAsFeet = value * 3.28
        case "Kilometers":
            inputAsFeet = value * 3280.84
        case "Yards":
            inputAsFeet = value * 3
        case "Miles":
            inputAsFeet = value * 5280
        case "Feet":
            inputAsFeet = value * 1
        default:
            inputAsFeet = value * 3.28
        }

        switch outputUnit {
        case "Meters":
            output = inputAsFeet / 3.28
        case "Kilometers":
            output = inputAsFeet / 3280.84
        case "Yards":
            output = inputAsFeet / 3
        case "Miles":
            output = inputAsFeet / 5280
        case "Feet":
            output = inputAsFeet / 1
        default:
            output = inputAsFeet / 3.28
        }
        
        return output
    }

    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount", value: $inputNumber, format: .number)
                        .keyboardType(.numbersAndPunctuation)
                        .textFieldStyle(.roundedBorder)
                        .focused($amountIsFocused)
                } header: {
                    Text ("Number to convert:")
                }
                
                Section {
                    Picker("Convert", selection: $inputUnit) {
                        ForEach (unitsOfLength, id: \.self){
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                    Picker("To", selection: $outputUnit) {
                        ForEach (unitsOfLength, id: \.self){
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                Section {
                    Text(result, format: .number)
                } header: {
                    Text("Number converted:")
                }
            }
            .navigationTitle("Length converter")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

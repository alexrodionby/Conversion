//
//  ContentView.swift
//  Conversion
//
//  Created by Alexandr Rodionov on 1.05.23.
//

import SwiftUI

struct ContentView: View {
    
    @State private var inputValue: Double = 1
    @State private var selectedInputType = "meters"
    @State private var selectedOutputType = "meters"
    @FocusState private var inputIsFocused: Bool
    
    private let distances = ["meters", "kilometers", "feet", "yards", "miles"]
    
    private var resultData: Double {
        
        var inputResult: Double {
            switch selectedInputType {
            case "kilometers":
                return inputValue * 1000
            case "feet":
                return inputValue * 0.3048
            case "yards":
                return inputValue * 0.9144
            case "miles":
                return inputValue * 1609.34
            default:
                return inputValue
            }
        }
        
        var outputResult: Double {
            switch selectedOutputType {
            case "kilometers":
                return inputResult / 1000
            case "feet":
                return inputResult / 0.3048
            case "yards":
                return inputResult / 0.9144
            case "miles":
                return inputResult / 1609.34
            default:
                return inputResult
            }
        }

        return outputResult
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Enter value", value: $inputValue, format: .number)
                        .keyboardType(.decimalPad)
                        .focused($inputIsFocused)
                    
                    Picker("Input data", selection: $selectedInputType) {
                        ForEach(distances, id: \.self) {
                            Text($0)
                        }
                    }
                } header: {
                    Text("Input value and type")
                }
                
                Section {
                    Picker("Output data", selection: $selectedOutputType) {
                        ForEach(distances, id: \.self) {
                            Text($0)
                        }
                    }
                    Text(resultData.formatted())

                } header: {
                    Text("Output value and type")
                }
                
            }
            .navigationTitle("Conversion")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        inputIsFocused = false
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

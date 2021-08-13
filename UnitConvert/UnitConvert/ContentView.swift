//
//  ContentView.swift
//  UnitConvert
//
//  Created by Aleksey Pestov on 13.08.2021.
//

import SwiftUI

struct ContentView: View {
    @State var inputText = ""
    @State var fromUnit = Unit.fahrenheit
    @State var toUnit = Unit.celsius
    
    var resultString: String {
        guard let input = Double(inputText) else {
            return ""
        }
        guard let converted = UnitConverter
                .convert(input, from: fromUnit, to: toUnit) else {
            return "Failed to convert"
        }
        return String(format: "%.1f", converted, toUnit.description) + toUnit.description
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Text("Welcome to unit converter!")
                }
                Section {
                    TextField("Enter temperature", text: $inputText)
                        .keyboardType(.decimalPad)
                }
                Section(header: Text("Choose units")) {
                    Picker("Convert from", selection: $fromUnit) {
                        ForEach(Unit.allCases, id: \.self) {id in
                            Text(id.description)
                        }
                    }
                    Picker("Convert to", selection: $toUnit) {
                        ForEach(Unit.allCases, id: \.self) {id in
                            Text(id.description)
                        }
                    }
                }
                Section(header: Text("Result")) {
                    Text(resultString)
                }
            }
            .navigationTitle(Text("Unit Converter"))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

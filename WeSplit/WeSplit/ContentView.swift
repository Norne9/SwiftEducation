//
//  ContentView.swift
//  WeSplit
//
//  Created by Aleksey Pestov on 11.08.2021.
//

import SwiftUI

struct ContentView: View {
    let tipPercentages = [10, 15, 20, 25, 0]
    
    @State private var checkAmountText = ""
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 2
    
    private var checkAmount: Double {
        let value = checkAmountText.replacingOccurrences(of: "$", with: "")
        if let amount = Double(value) {
            let tipPercent = Double(tipPercentages[tipPercentage]) / 100.0
            return amount + amount * tipPercent
        }
        return 0.0
    }
    
    private var totalPerPerson: Double {
        checkAmount / Double(numberOfPeople + 2)
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Welcome!")) {
                    Text("You can calculate your shares in this app")
                }
                Section {
                    TextField("Amount", text: $checkAmountText)
                        .keyboardType(.decimalPad)
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2..<100) {
                            Text("\($0) people")
                        }
                    }
                }
                Section(header: Text("How much tip you want to leave?")) {
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(tipPercentages.indices, id: \.self) {
                            Text("\(tipPercentages[$0])%")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                Section {
                    Text("Total with tip: $\(checkAmount, specifier: "%.2f")")
                    Text("Total per person: $\(totalPerPerson, specifier: "%.2f")")
                }
            }
            .navigationBarTitle("WeShare")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

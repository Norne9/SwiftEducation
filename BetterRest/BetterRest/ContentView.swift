//
//  ContentView.swift
//  BetterRest
//
//  Created by Aleksey Pestov on 25.08.2021.
//

import SwiftUI

struct ContentView: View {
    @State private var sleepAmount = 8.0
    @State private var wakeUp = Date()
    
    var sleepAmountText: String {
        let hours = Int(floor(sleepAmount))
        let minutes = Int((sleepAmount - Double(hours)) * 60.0)
        return "\(hours) hours \(minutes) minutes"
    }
    
    var body: some View {
        Form {
            Text("Hello, world!")
                .padding()
            Stepper(value: $sleepAmount, in: 4...12, step: 0.25) {
                Text(sleepAmountText)
            }
            DatePicker("Please enter a date", selection: $wakeUp, displayedComponents: .hourAndMinute)
                .labelsHidden()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

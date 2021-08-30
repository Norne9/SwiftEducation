//
//  ContentView.swift
//  BetterRest
//
//  Created by Aleksey Pestov on 25.08.2021.
//

import SwiftUI
import CoreML

struct ContentView: View {
    @State private var sleepAmount = 8.0
    @State private var wakeUp = defaultWakeTime
    @State private var coffeIndex = 0
    
    let model = try! SleepCalculator(configuration: MLModelConfiguration())
    
    var sleepAmountText: String {
        let hours = Int(floor(sleepAmount))
        let minutes = Int((sleepAmount - Double(hours)) * 60.0)
        return "\(hours) hours \(minutes) minutes"
    }
    
    var idealBedTime: String {
        let timeComponents = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
        let hour = (timeComponents.hour ?? 0) * 60 * 60
        let minute = (timeComponents.minute ?? 0) * 60
        do {
            let prediction = try model.prediction(wake: Double(hour + minute),
                                                  estimatedSleep: sleepAmount,
                                                  coffee: Double(coffeIndex + 1))
            let sleepTime = wakeUp - prediction.actualSleep
            
            let dateFormatter = DateFormatter()
            dateFormatter.timeStyle = .short
            
            return dateFormatter.string(from: sleepTime)
        } catch {
            return """
                Error
                \(error)
                """
        }
    }
    
    static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 8
        components.minute = 0
        return Calendar.current.date(from: components) ?? Date()
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("When do you want to wake up?")) {
                    DatePicker("Please enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute)
                        .labelsHidden()
                        .datePickerStyle(WheelDatePickerStyle())
                }
                
                Section(header: Text("Desired amount of sleep")) {
                    Stepper(value: $sleepAmount, in: 4...12, step: 0.25) {
                        Text(sleepAmountText)
                    }
                }
                
                Section(header: Text("Daily coffe intake")) {
                    Picker("Daily coffe intake", selection: $coffeIndex) {
                        ForEach(1..<21) { cup in
                            if cup == 1 {
                                Text("1 cup")
                            } else {
                                Text("\(cup) cups")
                            }
                        }
                    }
                    .pickerStyle(InlinePickerStyle())
                }
                
                Section(header: Text("Your ideal bedtime")) {
                    Text(idealBedTime)
                        .font(.largeTitle)
                }
            }
            .navigationBarTitle("Better Rest")
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    func calculateBedtime() {
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

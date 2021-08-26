//
//  ContentView.swift
//  BetterRest
//
//  Created by Aleksey Pestov on 25.08.2021.
//

import SwiftUI
import CoreML

struct AlertData {
    var showing: Bool = false
    var title: String = ""
    var message: String = ""
}

struct ContentView: View {
    @State private var sleepAmount = 8.0
    @State private var wakeUp = defaultWakeTime
    @State private var coffeAmount = 1
    
    @State private var alert = AlertData()
    
    let model = try! SleepCalculator(configuration: MLModelConfiguration())
    
    var sleepAmountText: String {
        let hours = Int(floor(sleepAmount))
        let minutes = Int((sleepAmount - Double(hours)) * 60.0)
        return "\(hours) hours \(minutes) minutes"
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
                    Stepper(value: $coffeAmount, in: 1...20) {
                        if coffeAmount == 1 {
                            Text("1 cup")
                        } else {
                            Text("\(coffeAmount) cups")
                        }
                    }
                }
            }
            .navigationBarTitle("Better Rest")
            .navigationBarItems(trailing: Button(action: calculateBedtime) {
                Text("Calculate")
            })
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .alert(isPresented: $alert.showing, content: {
            Alert(title: Text(alert.title), message: Text(alert.message), dismissButton: .default(Text("Ok")))
        })
    }
    
    func calculateBedtime() {
        let timeComponents = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
        let hour = (timeComponents.hour ?? 0) * 60 * 60
        let minute = (timeComponents.minute ?? 0) * 60
        do {
            let prediction = try model.prediction(wake: Double(hour + minute),
                                                  estimatedSleep: sleepAmount,
                                                  coffee: Double(coffeAmount))
            let sleepTime = wakeUp - prediction.actualSleep
            
            let dateFormatter = DateFormatter()
            dateFormatter.timeStyle = .short
            
            alert = AlertData(showing: true, title: "Your ideal bed time is",
                              message: dateFormatter.string(from: sleepTime))
        } catch {
            alert = AlertData(showing: true, title: "Error", message: """
                There was an error with your prediction:
                \(error)
                """)
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

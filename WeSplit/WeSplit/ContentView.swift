//
//  ContentView.swift
//  WeSplit
//
//  Created by Aleksey Pestov on 11.08.2021.
//

import SwiftUI

struct ContentView: View {
    let users = ["Norne", "Jaten", "Asperin", "Rolyx"]
    
    @State private var tapCount = 0
    @State private var selected = 0
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Text("Hello, world!")
                }
                Section {
                    Button("Tap Count: \(tapCount)") {
                        tapCount += 1
                    }
                }
                Section {
                    Picker("Select user", selection: $selected) {
                        ForEach(0..<users.count) { i in
                            Text(users[i])
                        }
                    }
                    Text("Selected \(users[selected])")
                }
            }
            .navigationBarTitle("SwiftUI Test")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

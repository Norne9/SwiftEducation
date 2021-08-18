//
//  ContentView.swift
//  Guess the Flag
//
//  Created by Aleksey Pestov on 18.08.2021.
//

import SwiftUI

struct ContentView: View {
    @State private var count: [Int] = [Int](repeating: 0, count: 3)
    @State private var showingAlert = false
    
    var body: some View {
        ZStack {
            //LinearGradient(gradient: Gradient(colors: [.gray, .black]), startPoint: .top, endPoint: .bottom)
            AngularGradient(gradient: Gradient(stops: [Gradient.Stop(color: .gray, location: 0),
                                                       Gradient.Stop(color: .black, location: 0.26)]),
                            center: .topLeading)
                .edgesIgnoringSafeArea(.all)
            VStack(spacing: 20) {
                ForEach(0..<3) { i in
                    Button {
                        count[i] += 1
                    } label: {
                        ZStack {
                            //Color.red.frame(width: 100, height: 100)
                            RadialGradient(gradient: Gradient(colors: [Color.red, Color.blue]),
                                           center: .center,
                                           startRadius: 10, endRadius: CGFloat(70 - count[i]))
                                .frame(width: 100, height: 100)
                            Text("\(count[i])")
                                .accentColor(.black)
                        }
                    }
                }
                Button {
                    showingAlert = true
                    for i in count.indices {
                        count[i] = 0
                    }
                } label: {
                    HStack {
                        Image(systemName: "pencil")
                        Text("Reset")
                    }
                }
            }
        }
        .alert(isPresented: $showingAlert) {
            Alert(title: Text("Hello SwiftUI!"),
                  message: Text("Counters were reverted to zero!"),
                  dismissButton: .default(Text("OK")))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

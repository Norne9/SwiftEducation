//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by Aleksey Pestov on 23.08.2021.
//

import SwiftUI

struct CalcButton: View {
    var text: String
    var color: Color
    var body: some View {
        Text(text)
            .foregroundColor(.white)
            .font(.largeTitle)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            .background(color)
    }
}

struct ContentView: View {
    @State private var useRed = false
    
    var body: some View {
        ZStack {
            Color(.sRGB, red: 0.1, green: 0.1, blue: 0.15, opacity: 1.0)
                .edgesIgnoringSafeArea(.all)
            VStack(spacing: 3) {
                Text("0")
                    .foregroundColor(.white)
                    .font(.largeTitle)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                HStack(spacing: 3) {
                    CalcButton(text: "AC", color: .yellow)
                    CalcButton(text: "+-", color: .yellow)
                    CalcButton(text: "%", color: .yellow)
                    CalcButton(text: "/", color: .orange)
                }
                HStack(spacing: 3) {
                    CalcButton(text: "7", color: .gray)
                    CalcButton(text: "8", color: .gray)
                    CalcButton(text: "9", color: .gray)
                    CalcButton(text: "X", color: .orange)
                }
                HStack(spacing: 3) {
                    CalcButton(text: "4", color: .gray)
                    CalcButton(text: "5", color: .gray)
                    CalcButton(text: "6", color: .gray)
                    CalcButton(text: "-", color: .orange)
                }
                HStack(spacing: 3) {
                    CalcButton(text: "1", color: .gray)
                    CalcButton(text: "2", color: .gray)
                    CalcButton(text: "3", color: .gray)
                    CalcButton(text: "+", color: .orange)
                }
                HStack(spacing: 3) {
                    CalcButton(text: "0", color: .gray)
                    HStack(spacing: 3) {
                        CalcButton(text: ",", color: .gray)
                        CalcButton(text: "=", color: .orange)
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

//
//  ContentView.swift
//  WordScramble
//
//  Created by Aleksey Pestov on 01.09.2021.
//

import SwiftUI

struct AlertData {
    var title: String = ""
    var message: String = ""
    var showing: Bool = false
}

struct ContentView: View {
    @State private var usedWords = [String]()
    @State private var rootWord = "word"
    @State private var newWord = ""
    @State private var alert = AlertData()
    
    var score: Int {
        usedWords.map { $0.count }.reduce(0, +)
    }
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Enter your word", text: $newWord, onCommit: addNewWord)
                    .autocapitalization(.none)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                Text("Score: \(score)")
                    .font(.headline)
                
                List(usedWords, id: \.self) {
                    Image(systemName: "\($0.count).circle")
                    Text($0)
                }
            }
            .navigationTitle(rootWord)
            .navigationBarItems(trailing: Button("Restart", action: startGame))
            .onAppear(perform: startGame)
        }
        .alert(isPresented: $alert.showing) {
            Alert(title: Text(alert.title), message: Text(alert.message), dismissButton: .default(Text("Ok")))
        }
    }
    
    func addNewWord() {
        let word = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        guard word.count > 0 else {
            return
        }
        guard isOriginal(word: word) else {
            showError(title: "Already used", message: "Use original words!")
            return
        }
        guard isPossible(word: word) else {
            showError(title: "Not possible", message: "There is no way to make \(word) from \(rootWord)!")
            return
        }
        guard isReal(word: word) else {
            showError(title: "No such word", message: "The word \(word) does not exist!")
            return
        }
        usedWords.insert(word, at: 0)
        newWord = ""
    }
    
    func startGame() {
        guard let url = Bundle.main.url(forResource: "start", withExtension: "txt") else {
            fatalError("Couldn't find start.txt file")
        }
        guard let contents = try? String(contentsOf: url) else {
            fatalError("Couldn't read start.txt file")
        }
        let wordList = contents.components(separatedBy: .whitespacesAndNewlines)
        
        usedWords = []
        newWord = ""
        rootWord = wordList.randomElement() ?? "error"
    }
    
    func isOriginal(word: String) -> Bool {
        !usedWords.contains(word)
    }
    
    func isPossible(word: String) -> Bool {
        var tempWord = rootWord
        for char in word {
            if let index = tempWord.firstIndex(of: char) {
                tempWord.remove(at: index)
            } else {
                return false
            }
        }
        return true
    }
    
    func isReal(word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspeledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0,
                                                           wrap: false, language: "en")
        return misspeledRange.location == NSNotFound
    }
    
    func showError(title: String, message: String) {
        alert = AlertData(title: title, message: message, showing: true)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

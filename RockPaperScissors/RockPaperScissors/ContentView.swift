//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Aleksey Pestov on 25.08.2021.
//

import SwiftUI

enum Move: CustomStringConvertible, CaseIterable {
    case rock
    case paper
    case scissors
    
    var description: String {
        switch self {
        case .rock:
            return "Rock"
        case .paper:
            return "Paper"
        case .scissors:
            return "Scissors"
        }
    }
}

enum GameResult: CustomStringConvertible {
    case win
    case lose
    case tie
    
    var description: String {
        switch self {
        case .win:
            return "You win!"
        case .lose:
            return "You lose!"
        case .tie:
            return "Tie!"
        }
    }
}

struct MoveButton: View {
    var title: String
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.largeTitle)
                .frame(maxWidth: .infinity)
                .padding()
                .foregroundColor(.white)
                .background(Color.blue)
                .clipShape(RoundedRectangle(cornerRadius: 5))
                .shadow(radius: 2)
        }
    }
}

struct AlertItem: Identifiable {
    var id = UUID()
    var title: Text
    var message: Text?
    var dismissButton: Alert.Button?
}

struct ContentView: View {
    let maxGames = 3
    
    @State private var alertItem: AlertItem? = nil
    @State private var score = 0
    @State private var gameNumber = 0
    
    
    var gameProgress: Float {
        Float(gameNumber) / Float(maxGames)
    }
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.white, Color(.sRGB, red: 0.8, green: 0.8, blue: 1.0, opacity: 1.0)]),
                           startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            VStack {
                Text("Rock Paper Scissors")
                    .font(.largeTitle)
                Text("Your score: \(score)")
                Spacer()
                ForEach(Move.allCases, id: \.self) { move in
                    MoveButton(title: move.description) {
                        makeMove(move)
                    }
                }
                .frame(maxWidth: 220)
                Spacer()
                ProgressView("Game Progress", value: gameProgress, total: 1.0)
            }
            .foregroundColor(.black)
            .padding()
        }
        .alert(item: $alertItem) { item in
            Alert(title: item.title, message: item.message, dismissButton: item.dismissButton)
        }
    }
    
    func makeMove(_ playerMove: Move) {
        let enemyMove = Move.allCases.randomElement()!
        
        let turnResult: GameResult
        switch (enemyMove, playerMove) {
        case (.paper, .scissors), (.rock, .paper), (.scissors, .rock):
            turnResult = .win
        case (let a, let b) where a == b:
            turnResult = .tie
        default:
            turnResult = .lose
        }
        
        switch turnResult {
        case .win: score += 1
        case .lose: score -= 1
        case .tie: break
        }
        
        let alertText = """
            Your move is \(playerMove)
            Enemy move is \(enemyMove)
            """
        alertItem = AlertItem(title: Text(turnResult.description),
                              message: Text(alertText),
                              dismissButton: .default(Text("Continue"), action: checkGameEnd))
    }
    
    func checkGameEnd() {
        gameNumber += 1
        if gameNumber >= maxGames {
            alertItem = AlertItem(title: Text("Game finished!"),
                                  message: Text("Your score is \(score)"),
                                  dismissButton: .default(Text("Play again!"), action: resetGame))
        }
    }
    
    func resetGame() {
        score = 0
        gameNumber = 0
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

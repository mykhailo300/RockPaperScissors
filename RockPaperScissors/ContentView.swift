//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Михайло Дмитрів on 22.12.2023.
//

import SwiftUI

struct ContentView: View {
    let moves = ["rock", "paper", "scissors"]
    let winningMoves = ["paper", "scissors", "rock"]
    let maxScore = 10
    @State private var moveToShow = Int.random(in: 0...2)
    @State private var shouldWin: Bool = Bool.random()
    @State private var currentChoice: String = ""
    
    @State private var showScore = false
    @State private var score = 0
    @State private var questionCount = 0
    
    var body: some View {
        VStack {
            Spacer()
            
            Text(moves[moveToShow])
            Text(shouldWin ? "Win" : "Lose")
            
            Spacer()
            
            ForEach(0..<3) {number in
                Button {
                    moveTapped(number)
                } label: {
                   Text(winningMoves[number])
                }
            }
            
            Spacer()
            
            Text(score, format: .number)
            
            Spacer()
        }
        .alert("Your result is \(score)/\(maxScore)", isPresented: $showScore) {
            Button("Restart", action: newGame)
        }
    }
    func newGame() {
        questionCount = 0
        score = 0
        
        nextMove()
    }
    func nextMove() {
        questionCount += 1
        shouldWin = Bool.random()
        moveToShow = Int.random(in: 0...2)
        if questionCount == 10 {
            showScore = true
        }
    }
    func moveTapped(_ number: Int) {
        if moves[moveToShow] == winningMoves[number] {
            nextMove()
        } else if shouldWin {
            if moveToShow == number {
                score += 1
            }
            nextMove()
        } else {
            if moveToShow != number {
                score += 1
            }
            nextMove()
        }
    }
}

#Preview {
    ContentView()
}

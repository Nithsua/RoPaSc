//
//  ContentView.swift
//  RoPaSc Teaser
//
//  Created by Nivas Muthu M G on 29/06/21.
//

import SwiftUI

struct ButtonView: View {
    let text: String
    let content: () -> ()
    var body: some View {
        Button(action: content) {
            Image(text)
                .renderingMode(.original)
                .resizable()
                .scaledToFit()
                .padding()
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 20.0))
                .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
        }
    }
}

struct ContentView: View {
    let moves = ["Rock", "Paper", "Scissor"]
    @State private var sysChoice = Int.random(in: 0..<3)
    @State private var shouldWin = Bool.random()
    @State private var questionCount = 0
    @State private var score = 0
    @State private var scoreShown = false
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.green, Color.purple]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea(.all)
            VStack(spacing: 30) {
                Text("Your Score: \(score)")
                    .font(.title2)
                    .foregroundColor(.white)
                    
                HStack{
                    Image(moves[sysChoice])
                        .resizable()
                        .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
                        .padding(.trailing)
        
                    Text(shouldWin ? "Win" : "Lose")
                        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.gray)
                        .clipShape(RoundedRectangle(cornerRadius: 15.0))
                        .overlay(RoundedRectangle(cornerRadius: 15.0).stroke(Color.white, lineWidth: 2.0))
                        .shadow(radius: 5)
                        .padding()
                }
                
                HStack(spacing: 20) {
                    ForEach(0..<moves.count, id: \.self) { index in
                        ButtonView(text: moves[index]) {
                            checkAnswer(index: index)
                        }
                    }
                }
                .padding()
            }
        }.alert(isPresented: $scoreShown){
            Alert(title: Text("Game Ended"), message: Text("Your Score is \(score)"), dismissButton: .default(Text("Start New Game"), action: {
                reset()
            }))
        }
    }
    
    func checkAnswer(index: Int) {
        if (index - sysChoice == 1) || (index - sysChoice == -2) {
            if shouldWin == true {
                score += 1
            } else {
                score -= 1
            }
        } else if (index - sysChoice == 2) || (index - sysChoice == -1){
            if shouldWin == false {
                score += 1
            } else {
                score -= 1
            }
        } else {
            score -= 1
        }
        
        if questionCount < 9 {
            nextQuestion()
        } else {
            scoreShown = true
        }
    }
    
    func nextQuestion() {
        questionCount += 1
        sysChoice = Int.random(in: 0..<3)
        shouldWin = Bool.random()
    }
    
    func reset() {
        score = 0
        questionCount = 0
        sysChoice = Int.random(in: 0..<3)
        shouldWin = Bool.random()
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

//  ContentView.swift
//  GuessTheAnimal
//  Created on 7/4/26.
import SwiftUI

struct ContentView: View {
    @State private var animals = ["Lion", "Elephant", "Giraffe", "Panda", "Penguin", "Fox", "Koala", "Tiger", "Zebra", "Owl"].shuffled()
    @State private var score = 0
    @State private var correctAnswer = Int.random(in: 0...2)
    //@State private var isQuestionCorrect = false
    @State private var scoreTitle = ""
    @State private var isShowingAnswer = false
    
    var body: some View {
        VStack {
            ZStack {
                RadialGradient(colors: [
                    .init(.red),
                    .init(.blue)
                ], center: .center, startRadius: 200, endRadius: 400)
                .ignoresSafeArea()
                
                VStack {
                    VStack {
                        Text("Guess The Animal")
                            .font(.largeTitle.bold())
                            .foregroundStyle(.primary)
                    }
                    .padding(.top, 8)
                    
                    Spacer()
                    
                    VStack {
                        Text("Guess the animal of")
                            .font(.title)
                            .foregroundStyle(.primary)
                        
                        Text(animals[correctAnswer])
                            .font(.headline.bold())
                            .foregroundStyle(.primary)
                        
                        VStack(spacing: 10) {
                            ForEach(0..<3, id: \.self) { number in
                                Button {
                                    animalTapped(number)
                                } label: {
                                    Image(animals[number])
                                        .clipShape(.capsule)
                                        .shadow(radius: 5)
                                        .scaledToFit()
                                }
                            }
                        }
                        .alert(scoreTitle, isPresented: $isShowingAnswer) {
                            Button("Continue") {
                                animals.shuffle()
                                correctAnswer = Int.random(in: 0...2)
                                isShowingAnswer = false
                            }
                        } message: {
                            Text("Your score is now \(score)")
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 20)
                    .background(.regularMaterial)
                    .clipShape(.rect(cornerRadius: 20))
                    
                    Spacer()
                    Spacer()
                    
                    VStack {
                        Text("Score: \(score)")
                            .font(.title)
                            .foregroundStyle(.primary)
                        Button {
                            score = 0
                        } label: {
                            Text("Reset")
                        }
                        .buttonStyle(.glassProminent)
                    }
                    Spacer()
                }
            }
        }
    }
    
    func addingScore() {
        withAnimation(.easeInOut) {
            score += 1
        }
}
    func subtractingScore() {
        if score == 0 {
            withAnimation(.smooth) {
                score -= 0
            }
        } else {
            withAnimation {
                score -= 1
            }
        }
    }
    
    func animalTapped(_ number: Int) {
        if number == correctAnswer {
            addingScore()
            scoreTitle = "Correct"
            isShowingAnswer = true
        } else {
            subtractingScore()
            scoreTitle = "Wrong! That's the \(animals[number])"
            isShowingAnswer = true
        }
    }
}

#Preview {
    ContentView()
}

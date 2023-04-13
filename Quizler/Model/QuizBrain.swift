//
//  QuizBrain.swift
//  Quizler
//
//  Created by Леонид Турко on 12.04.2023.
//

import Foundation

struct QuizBrain {
  var questionNumber = 0
  var correctAnswers = 0
  
  let quiz = [
    Question(text: "Which is the largest organ in the human body?", answers: ["Heart", "Skin", "Large Intestine"], correctAnswer: "Skin"),
    Question(text: "Five dollars is worth how many nickels?", answers: ["25", "50", "100"], correctAnswer: "100"),
    Question(text: "What do the letters in the GMT time zone stand for?", answers: ["Global Meridian Time", "Greenwich Mean Time", "General Median Time"], correctAnswer: "Greenwich Mean Time"),
    Question(text: "What is the French word for 'hat'?", answers: ["Chapeau", "Écharpe", "Bonnet"], correctAnswer: "Chapeau"),
    Question(text: "In past times, what would a gentleman keep in his fob pocket?", answers: ["Notebook", "Handkerchief", "Watch"], correctAnswer: "Watch"),
    Question(text: "How would one say goodbye in Spanish?", answers: ["Au Revoir", "Adiós", "Salir"], correctAnswer: "Adiós"),
    Question(text: "Which of these colours is NOT featured in the logo for Google?", answers: ["Green", "Orange", "Blue"], correctAnswer: "Orange"),
    Question(text: "What alcoholic drink is made from molasses?", answers: ["Rum", "Whisky", "Gin"], correctAnswer: "Rum"),
    Question(text: "What type of animal was Harambe?", answers: ["Panda", "Gorilla", "Crocodile"], correctAnswer: "Gorilla"),
    Question(text: "Where is Tasmania located?", answers: ["Indonesia", "Australia", "Scotland"], correctAnswer: "Australia")
  ]
  
  mutating func checkAnswer(_ userUnswer: String) -> Bool {
    let correctAnswer = quiz[questionNumber].correctAnswer
    if userUnswer == correctAnswer {
      correctAnswers += 1
      return true
    } else {
      return false
    }
  }
  
  func getQuestionText() -> String {
    quiz[questionNumber].text
  }
  
  func getAnswerText() -> [String] {
    quiz[questionNumber].answers
  }
  
  func getProgress() -> Float {
    Float(questionNumber) / Float(quiz.count)
  }
  
  mutating func nexQuestion() {
    if questionNumber < quiz.count - 1 {
    questionNumber += 1
    } else {
      questionNumber = 0
      correctAnswers = 0
    }
  }
  
  func getScore() -> Int {
    correctAnswers
  }
}

//
//  Game.swift
//  4
//
//  Created by Artem Firsov on 12/17/21.
//

import Foundation

class Game {
    
    static let shared = Game()
    
    private let careTaker = Caretaker()
    
    weak var gameSession: GameSession?
    private(set) var games: [Games] {
        didSet {
            careTaker.saveResults(game: self.games)
        }
    }
    
    private init() {
        self.games = careTaker.retrieveResults()
        self.questions = careTaker.retrieveQuestions()
    }
    
    func addGame(game: Games) {
        games.append(game)
    }
    
    func addQustion(question: Question) {
        questions.append(question)
    }
    
    private(set) var questions: [Question] {
        didSet {
            careTaker.saveQuestions(question: self.questions)
        }
    }
}

struct Games: Codable {
    var trueAnswer: Int = 0
    var allAnswer: Int = 3
    var cash: Int = 0
}

struct Question: Codable {
    var questionText: String
    var answersText: [String]
    var trueAnswer: Int
}

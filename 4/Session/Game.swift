//
//  Game.swift
//  4
//
//  Created by Artem Firsov on 12/17/21.
//

import Foundation

class Game {
    
    static let shared = Game()
    
    private let resultsCareTaker = ResultsCaretaker()

    weak var gameSession: GameSession?
    private(set) var games: [Games] {
        didSet {
            resultsCareTaker.saveResults(game: self.games)
        }
    }
    
    private init() {
        self.games = resultsCareTaker.retrieveResults()
    }
    
    func addGame(game: Games) {
        games.append(game)
    }
}

struct Games: Codable {
    var trueAnswer: Int = 0
    var allAnswer: Int = 3
    var cash: Int = 0
}

//
//  GameSession.swift
//  4
//
//  Created by Artem Firsov on 12/17/21.
//

import Foundation

class GameSession: GameVCDelegate {
    func didGameFinish(trueAnswers: Int) {
        Game.shared.addGame(game: calculateSession(answers: trueAnswers))
    }
    
    
    var trueAnswers: Int = 0
    var allAnswers: Int = 3
    var cash: Int = 0
    
    func calculateSession(answers: Int) -> Games {
        let session = GameViewController()
        session.delegate = self
        self.trueAnswers = answers
        self.cash = answers * 1000 * 2
        return Games(trueAnswer: self.trueAnswers, allAnswer: allAnswers, cash: self.cash)
    }
}

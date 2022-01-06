//
//  DifficultyStrategy.swift
//  4
//
//  Created by Artem Firsov on 12/21/21.
//

import Foundation

enum GameMode {
    case random, linear
}

protocol GameModeStrategy {
    func shuffler (gameMode: GameMode, array: [Question]) -> [Int]
}

class MillionaireStrategy: GameModeStrategy {
    
    var questionIndex: [Int]!
    
    func shuffler(gameMode: GameMode, array: [Question]) -> [Int] {
        if gameMode == .random {
            questionIndex = Array(0..<array.count)
            questionIndex.shuffle()
            return questionIndex
            } else {
                questionIndex = Array(0..<array.count)
                return questionIndex
        }
    }
    
    
}

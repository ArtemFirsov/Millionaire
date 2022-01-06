//
//  ResultsCaretaker.swift
//  4
//
//  Created by Artem Firsov on 12/21/21.
//

import Foundation

class Caretaker {
    
    let encoder = JSONEncoder()
    let decoder = JSONDecoder()
    
    private var resultsKey = "gameResults"
    private var questionKey = "questionKey"
    
    func saveResults(game: [Games]) {
        do {
            let data = try? self.encoder.encode(game)
            UserDefaults.standard.setValue(data, forKey: resultsKey)
        } catch {
            print(error)
        }
    }
    
    func retrieveResults() -> [Games] {
        guard let data = UserDefaults.standard.data(forKey: resultsKey) else { return [] }
        do {
            return try self.decoder.decode([Games].self, from: data)
        } catch {
            print(error)
            return []
        }
    }
    
    func saveQuestions(question: [Question]) {
        do {
            let data = try? self.encoder.encode(question)
            UserDefaults.standard.setValue(data, forKey: questionKey)
        } catch {
            print(error)
        }
    }
    
    func retrieveQuestions() -> [Question] {
        guard let data = UserDefaults.standard.data(forKey: questionKey) else { return [] }
        do {
            return try self.decoder.decode([Question].self, from: data)
        } catch {
            print(error)
            return []
        }
    }
}


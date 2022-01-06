//
//  GameViewController.swift
//  4
//
//  Created by Artem Firsov on 12/16/21.
//

import UIKit

protocol GameVCDelegate: AnyObject {
    func didGameFinish(trueAnswers: Int)
}

class GameViewController: UIViewController {

    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var fourthAnswer: UIButton!
    @IBOutlet weak var thirdAnswer: UIButton!
    @IBOutlet weak var secondAnswer: UIButton!
    @IBOutlet weak var firstAnswer: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var observerLabel: UILabel!
    
    lazy var buttons: [UIButton] = { return [firstAnswer, secondAnswer, thirdAnswer, fourthAnswer]}()
    var questions = Game.shared.questions
    
    var questionIndex: [Int]!
    var currentIndex = Observable<Int>(0)
//    weak var gameSession: GameSession?
    var currentMode: GameMode = .random
    var questionsStrategy: GameModeStrategy {
        switch currentMode {
        case .random:
            return MillionaireStrategy()
        case .linear:
            return MillionaireStrategy()
        }
    }
    
    weak var delegate: GameVCDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        questionIndex = questionsStrategy.shuffler(gameMode: currentMode, array: questions)
        updateTextsForQuestions(index: 0)
        currentIndex.addObserver(self, options: [.new, .initial]) { [weak self] (currentIndex, _) in
            self?.observerLabel.text = "Текущий вопрос: \(currentIndex + 1)"
        }
        print(self.questions.count)
    }
    
    func updateTextsForQuestions(index: Int) {
        for button in buttons {
            button.backgroundColor = .black
        }
        guard index < questions.count else {
            nextButton.isHidden = true
            return
        }
        currentIndex.value = index
//        hideNextButton()
        nextButton.isHidden = true
        
        let questionObject = questions[questionIndex[index]]
        questionLabel.text = questionObject.questionText
        for (answerIndex, button) in buttons.enumerated() {
            button.setTitle(questionObject.answersText[answerIndex], for: .normal)
        }
    }
    
    @IBAction func didTapOnAnswerButton(button: UIButton) {
        nextButton.isHidden = false
        
        let buttonIndex = buttons.firstIndex(of: button)
        let questionObject = questions[questionIndex[currentIndex.value]]
        
        if buttonIndex == questionObject.trueAnswer {
            button.backgroundColor = .green
            sleep(1)
            if currentIndex.value == questions.count - 1 {
                currentIndex.value += 1
                didGameFinish(trueAnswers: currentIndex.value)
                dismiss(animated: true, completion: nil)
            }
//            gameSession?.trueAnswers += 1
        } else {
            button.backgroundColor = .red
            sleep(1)
            dismiss(animated: true, completion: nil)
            didGameFinish(trueAnswers: currentIndex.value)
//            gameSession?.trueAnswers = 0
        }
    }
    
    @IBAction func didTapNextButton(sender: AnyObject) {
        updateTextsForQuestions(index: currentIndex.value + 1)
    }

}

extension GameViewController: GameVCDelegate {
    func didGameFinish(trueAnswers: Int) {
        print(currentIndex)
        self.delegate?.didGameFinish(trueAnswers: trueAnswers + 1)
        let out = Games(trueAnswer: trueAnswers, allAnswer: 3, cash: trueAnswers * 2000)
        Game.shared.addGame(game: out)
    }
    
}

//
//  ViewController.swift
//  4
//
//  Created by Artem Firsov on 12/9/21.
//

import UIKit

class MainMenuViewController: UIViewController {

    @IBOutlet weak var difficultyControl: UISegmentedControl!
    
    @IBAction func questionAdder(_ sender: Any) {
        alertWindow(alertText: "Добавить вопрос")
    }
    
    var addIteration: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    private var selectedMode: GameMode {
        switch self.difficultyControl.selectedSegmentIndex {
        case 1:
            return .linear
        default:
            return .random
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toGameSegue" {
            guard let dst = segue.destination as? GameViewController else {return}
            dst.currentMode = selectedMode
        }
    }
    var question = Question(questionText: "", answersText: [], trueAnswer: 0)
    var tmpAnswers: [String] = []
}

extension MainMenuViewController {
    
    func alertWindow(alertText: String) {
        let controller = UIAlertController(title: "Новый вопрос", message: "Введите текст вопроса", preferredStyle: .alert)
        self.addIteration = 0
        controller.addTextField { (textField: UITextField) in
            textField.placeholder = ""
        }
        
            let addButton = UIAlertAction(title: "Далее", style: .default) { [weak self] _ in
                guard let self = self else { return }
                if let textFelds = controller.textFields {
                    let theTextField = textFelds as [UITextField]
                    let enteredText = textFelds[0].text
                    if enteredText == "" {
                        self.okAlert(alertText: "Нужно ввести текст вопроса", iteration: self.addIteration)
                    } else {
                        self.question.questionText = enteredText ?? ""
                        self.addIteration += 1
                        print(self.addIteration)
                        self.nextWindow(alertText: "Введите текст ответа")
                        print(self.question)
                        
                    }
                }
            }
        let cancelButton = UIAlertAction(title: "Отмена", style: .destructive) { [weak self] _ in
            guard let self = self else { return }
            self.addIteration = 0
        }
            controller.addAction(addButton)
            controller.addAction(cancelButton)
            self.present(controller, animated: true, completion: nil)
        
    }
    
    func okAlert(alertText: String, iteration: Int) {
        let alertController = UIAlertController(title: "Ok", message: alertText, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "Ok", style: .cancel) { _ in
            switch iteration {
            case 0:
                self.alertWindow(alertText: "Добавить вопрос")
            case 1...3:
                self.nextWindow(alertText: "Введите текст ответа")
            case 4:
                self.endWindow(alertText: "Введите номер верного ответа от 1 до 4")
            default:
                return
            }
            
        }
        alertController.addAction(okButton)
        present(alertController, animated: true, completion: nil)
        
    }
    
    func nextWindow(alertText: String) {
        let controller = UIAlertController(title: "Новый вопрос", message: alertText, preferredStyle: .alert)
        controller.addTextField { (textField: UITextField) in
            textField.placeholder = ""
        }
        
            let addButton = UIAlertAction(title: "Далее", style: .default) { [weak self] _ in
                guard let self = self else { return }
                if let textFelds = controller.textFields {
                    let theTextField = textFelds as [UITextField]
                    let enteredText = textFelds[0].text
                    if enteredText == "" {
                        self.okAlert(alertText: "Нужно ввести текст ответа", iteration: self.addIteration)
                    } else if self.addIteration < 4 {
                        self.tmpAnswers.append(enteredText ?? "")
                            print(self.question)
                            self.addIteration += 1
                        print(self.addIteration)
                            self.nextWindow(alertText: "Введите текст ответа")
                        } else {
                            self.tmpAnswers.append(enteredText ?? "")
                            self.question.answersText = self.tmpAnswers
                            self.endWindow(alertText: "Введите номер верного ответа от 1 до 4")
                            print(self.question)
                        }
                }
            }
            let cancelButton = UIAlertAction(title: "Отмена", style: .destructive) { [weak self] _ in
                guard let self = self else { return }
                self.addIteration = 0
            }
            controller.addAction(addButton)
            controller.addAction(cancelButton)
            self.present(controller, animated: true, completion: nil)
    }
    
    func endWindow(alertText: String) {
        let controller = UIAlertController(title: "Новый вопрос", message: alertText, preferredStyle: .alert)
        controller.addTextField { (textField: UITextField) in
            textField.placeholder = ""
        }
        
            let addButton = UIAlertAction(title: "Далее", style: .default) { [weak self] _ in
                guard let self = self else { return }
                if let textFelds = controller.textFields {
                    let theTextField = textFelds as [UITextField]
                    let enteredText = textFelds[0].text
                    if enteredText == "1" || enteredText == "2" || enteredText == "3" || enteredText == "4" {
                        let intText = (enteredText as? NSString)?.integerValue
                        guard let int: Int = intText else { return }
                        self.question.trueAnswer = int - 1
                        print(self.question)
                        self.addIteration = 0
                        
                    } else {
                        self.okAlert(alertText: "Нужно ввести цисло от 1 до 4", iteration: self.addIteration)
                    }
                }
            }
            let cancelButton = UIAlertAction(title: "Отмена", style: .destructive) { [weak self] _ in
                guard let self = self else { return }
                self.addIteration = 0
            }
            controller.addAction(addButton)
            controller.addAction(cancelButton)
            self.present(controller, animated: true, completion: nil)
        
    }
}

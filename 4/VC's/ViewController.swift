//
//  ViewController.swift
//  4
//
//  Created by Artem Firsov on 12/9/21.
//

import UIKit

class MainMenuViewController: UIViewController {

    @IBOutlet weak var difficultyControl: UISegmentedControl!
    
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

}


//
//  ViewController.swift
//  Tipsy
//
//  Created by Angela Yu on 09/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let showResultSegue = "showResult"
    
    @IBOutlet weak var tip0: UIButton!
    @IBOutlet weak var tip10: UIButton!
    @IBOutlet weak var tip20: UIButton!
    @IBOutlet weak var stepperLabel: UILabel!
    
    var tips = [UIButton: Int]()
    
    var model = SplitModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tips = [
            tip0: 0,
            tip10: 10,
            tip20: 20
        ]
    }

    @IBAction func tipPressed(_ sender: UIButton) {
        model.selectedTip = tips[sender]!
        for button in tips.keys {
            button.isSelected = sender == button
        }
    }
    
    @IBAction func splitStepper(_ sender: UIStepper) {
        model.peopleCount = Int(sender.value)
        stepperLabel.text = model.peopleCount.description
    }
    
    @IBAction func billChanged(_ sender: UITextField) {
        model.bill = Double(sender.text ?? "") ?? 0.0
    }
    
    
    @IBAction func calculatePressed(_ sender: UIButton) {
        performSegue(withIdentifier: showResultSegue, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == showResultSegue {
            let resultView = segue.destination as! ResultViewController
            resultView.model = model
        }
    }
}


//
//  ViewController.swift
//  BMI Calculator
//
//  Created by Angela Yu on 21/08/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit

class CalculateViewController: UIViewController {
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var heightSlider: UISlider!
    @IBOutlet weak var weightSlider: UISlider!
    
    var calcultorBrain = CalculatorBrain()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        heightSlider.value = 1.8
        onHeightChanged(heightSlider)
        weightSlider.value = 100.0
        onWeightChanged(weightSlider)
    }

    @IBAction func onHeightChanged(_ sender: UISlider) {
        heightLabel.text = String(format: "%.2fm", sender.value)
        calcultorBrain.height = Double(sender.value)
    }
    
    @IBAction func onWeightChanged(_ sender: UISlider) {
        weightLabel.text = String(format: "%.0fKg", sender.value)
        calcultorBrain.weight = Double(sender.value)
    }
    
    @IBAction func calculatePressed(_ sender: UIButton) {
        performSegue(withIdentifier: "goToResult", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToResult" {
            let destVC = segue.destination as! ResultViewController
            destVC.bmi = calcultorBrain.bmi
        }
    }
}


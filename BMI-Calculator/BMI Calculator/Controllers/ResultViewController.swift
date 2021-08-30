//
//  ResultViewController.swift
//  BMI Calculator
//
//  Created by Aleksey Pestov on 30.08.2021.
//  Copyright © 2021 Angela Yu. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {
    @IBOutlet weak var bmiLabel: UILabel!
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var adviceLabel: UILabel!
    
    var bmi: BMI? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let bmi = bmi else { return }

        bmiLabel.text = String(format: "%.1f", bmi.value)
        adviceLabel.text = bmi.advice
        backgroundImage.backgroundColor = bmi.color
    }
    
    @IBAction func recalculatePressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}

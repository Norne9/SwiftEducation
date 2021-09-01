//
//  ResultViewController.swift
//  Tipsy
//
//  Created by Aleksey Pestov on 01.09.2021.
//  Copyright © 2021 The App Brewery. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {
    @IBOutlet weak var perPersonLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    
    var model: SplitModel! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        perPersonLabel.text = String(format: "%.2f", model.result)
        statusLabel.text = "Split between \(model.peopleCount) people, with \(model.selectedTip)% tip."
    }
    
    @IBAction func recalculatePressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}

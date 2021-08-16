//
//  ViewController.swift
//  Destini-iOS13
//
//  Created by Angela Yu on 08/08/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var storyLabel: UILabel!
    @IBOutlet weak var choice1Button: UIButton!
    @IBOutlet weak var choice2Button: UIButton!
    
    var storyBrain = StoryBrain()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }

    @IBAction func onChoice(_ sender: UIButton) {
        guard let choice = sender.currentTitle else { return }
        storyBrain.makeChoice(choice)
        updateUI()
    }
    
    func updateUI(){
        storyLabel.text = storyBrain.title
        choice1Button.setTitle(storyBrain.choice1, for: .normal)
        choice2Button.setTitle(storyBrain.choice2, for: .normal)
    }
}


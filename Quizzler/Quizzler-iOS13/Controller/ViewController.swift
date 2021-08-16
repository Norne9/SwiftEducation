//
//  ViewController.swift
//  Quizzler-iOS13
//
//  Created by Angela Yu on 12/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    
    @IBOutlet weak var choice1: UIButton!
    @IBOutlet weak var choice2: UIButton!
    @IBOutlet weak var choice3: UIButton!
    
    var quizBrain = QuizBrain()
    var choices: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        choices = [choice1, choice2, choice3]
        updateUI()
    }
    
    @IBAction func answerButtonPressed(_ sender: UIButton) {
        guard let answer = sender.currentTitle else { return }
        
        if quizBrain.checkAnswer(answer) {
            sender.backgroundColor = .green
        } else {
            sender.backgroundColor = .red
        }
        
        quizBrain.nextQuestion()
        Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(updateUI), userInfo: nil, repeats: false)
    }
    
    @objc func updateUI(){

        questionLabel.text = quizBrain.question
        progressBar.progress = quizBrain.progress
        scoreLabel.text = "Score: \(quizBrain.score)"
    
        for (answer, choice) in zip(quizBrain.answers, choices) {
            choice.backgroundColor = .clear
            choice.setTitle(answer, for: .normal)
        }
    }
}


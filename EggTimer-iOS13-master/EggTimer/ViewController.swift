//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var progress: UIProgressView!
    let cookingTimes = [
        "Soft": 5,
        "Medium": 7,
        "Hard": 12
    ]
    var timer: Timer?
    var countdown: Int = 0
    var selectedTime: Int = 0
    var timerSound: AVAudioPlayer!
    
    override func viewDidLoad() {
        let path = Bundle.main.path(forResource: "alarm_sound.mp3", ofType:nil)!
        let url = URL(fileURLWithPath: path)
        timerSound = try! AVAudioPlayer(contentsOf: url)
    }
    
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        let hardness = sender.currentTitle ?? "empty"
        guard let time = cookingTimes[hardness] else {
            print("Unknown hardness: \(hardness)")
            return
        }
        
        selectedTime = time
        countdown = time
        
        timer?.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        timer?.tolerance = 0.1
        updateTimer()
    }
    
    @objc func updateTimer() {
        titleLabel.text = "Wait \(countdown) seconds..."
        progress.progress = 1.0 - Float(countdown) / Float(selectedTime);
        
        if countdown <= 0 {
            timer?.invalidate()
            titleLabel.text = "Done!"
            timerSound.play()
            return
        }
        countdown -= 1
    }
}

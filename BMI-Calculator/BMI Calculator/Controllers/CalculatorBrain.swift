//
//  CalculatorBrain.swift
//  BMI Calculator
//
//  Created by Aleksey Pestov on 30.08.2021.
//  Copyright © 2021 Angela Yu. All rights reserved.
//

import Foundation

struct CalculatorBrain {
    var height = 0.0
    var weight = 0.0
    
    var bmi: BMI {
        let bmiValue = weight / height / height
        if bmiValue < 18.5 {
            return BMI(value: bmiValue, advice: "Eat more", color: #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1))
        } else if bmiValue < 24.9 {
            return BMI(value: bmiValue, advice: "You are fine", color: #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1))
        } else {
            return BMI(value: bmiValue, advice: "Eat less", color: #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1))
        }
    }
}

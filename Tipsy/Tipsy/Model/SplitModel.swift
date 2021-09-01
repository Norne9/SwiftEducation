//
//  SplitModel.swift
//  Tipsy
//
//  Created by Aleksey Pestov on 01.09.2021.
//  Copyright © 2021 The App Brewery. All rights reserved.
//

import Foundation

struct SplitModel {
    var selectedTip = 10
    var peopleCount = 2
    var bill = 0.0
    
    var result: Double {
        let withTip = bill + bill * Double(selectedTip) / 100.0
        return withTip / Double(peopleCount)
    }
}

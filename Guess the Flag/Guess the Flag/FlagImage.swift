//
//  FlagImage.swift
//  Guess the Flag
//
//  Created by Aleksey Pestov on 23.08.2021.
//

import SwiftUI

struct FlagImage: View {
    var image: String
    var body: some View {
        Image(image)
            .renderingMode(.original)
            .clipShape(Capsule())
            .overlay(Capsule().stroke(Color.black, lineWidth: 1.0))
            .shadow(color: .black, radius: 2)
    }
}

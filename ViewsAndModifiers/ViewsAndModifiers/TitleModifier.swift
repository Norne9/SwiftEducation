//
//  TitleModifier.swift
//  ViewsAndModifiers
//
//  Created by Aleksey Pestov on 23.08.2021.
//

import SwiftUI

struct Title: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundColor(.white)
            .padding()
            .background(Color.green)
            .clipShape(Capsule())
    }
}

extension View {
    func titleStyle() -> some View {
        self.modifier(Title())
    }
}

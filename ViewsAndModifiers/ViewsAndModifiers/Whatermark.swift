//
//  Whatermark.swift
//  ViewsAndModifiers
//
//  Created by Aleksey Pestov on 23.08.2021.
//

import SwiftUI

struct Watermark: ViewModifier {
    var text: String
    func body(content: Content) -> some View {
        ZStack(alignment: .bottomTrailing) {
            content
            Text(text)
                .font(.caption)
                .foregroundColor(.white)
                .padding(5)
                .background(Color.black)
        }
    }
}

extension View {
    func whatermarked(with text: String) -> some View {
        self.modifier(Watermark(text: text))
    }
}

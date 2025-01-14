//
//  BlackGradientModifier.swift
//  MoviesDB
//
//  Created by Elif Parlak on 14.01.2025.
//

import SwiftUI

struct BlackGradientModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .overlay(
                RoundedRectangle(cornerRadius: 15)
                    .fill(
                        LinearGradient(
                            gradient: Gradient(colors: [
                                Color.black.opacity(0.6),
                                Color.black.opacity(0.1)
                            ]),
                            startPoint: .top,
                            endPoint: .center
                        )
                    )
            )
    }
}

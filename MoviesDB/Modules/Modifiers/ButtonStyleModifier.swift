//
//  ButtonStyleModifier.swift
//  MoviesDB
//
//  Created by Elif Parlak on 13.01.2025.
//

import Foundation
import SwiftUI

struct ButtonStyleModifier: ViewModifier {
    enum Style {
        case filled
        case outlined
    }
    
    let style: Style
    
    func body(content: Content) -> some View {
        switch style {
        case .filled:
            content
                .padding(.vertical, 10)
                .padding(.horizontal, 25)
                .background(Color.gray.opacity(0.5))
                .foregroundColor(.white)
                .font(.system(size: 16, weight: .bold))
                .clipShape(Capsule())
        case .outlined:
            content
                .padding(.vertical, 10)
                .padding(.horizontal, 25)
                .background(Color.clear)
                .foregroundColor(.white)
                .font(.system(size: 16, weight: .bold))
                .overlay(
                    Capsule()
                        .stroke(Color.gray, lineWidth: 2)
                )
        }
    }
}

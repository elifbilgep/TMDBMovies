//
//  CircleModifier.swift
//  MoviesDB
//
//  Created by Elif Parlak on 13.01.2025.
//

import SwiftUI

struct CircleModifier: ViewModifier {

    func body(content: Content) -> some View {
        content
            .foregroundStyle(.gray.opacity(0.3))
            .frame(width: 50)
    
    }
}

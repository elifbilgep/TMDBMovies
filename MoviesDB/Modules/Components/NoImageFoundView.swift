//
//  NoImageFoundView.swift
//  MoviesDB
//
//  Created by Elif Parlak on 13.01.2025.
//

import SwiftUI

struct NoImageFoundView: View {
    var body: some View {
        Image(systemName: "exclamationmark.square.fill")
            .resizable()
            .scaledToFit()
            .frame(width: 100, height: 150)
            .foregroundColor(.gray)
            .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}

#Preview {
    NoImageFoundView()
}

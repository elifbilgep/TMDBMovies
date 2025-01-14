//
//  FavoritesView.swift
//  MoviesDB
//
//  Created by Elif Parlak on 12.01.2025.
//

import SwiftUI

struct FavoritesView: View {
    @StateObject private var viewModel: FavoritesViewModel
    
    init(viewModel: FavoritesViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    private let columns = [
        GridItem(.flexible()), // First column
        GridItem(.flexible())  // Second column
    ]
    var body: some View {
        ScrollView {
            VStack {
                Text("Favorites")
                    .font(.system(size: 32, weight: .semibold))
                    .frame(width: UIScreen.screenWidth - 50, alignment: .leading)
                    .padding()
                LazyVGrid(columns: columns, spacing: 16) {
                    ForEach(viewModel.favorites, id: \.self) { favorite in
                        AsyncImage(url: favorite.fullPosterURL) { phase in
                            switch phase {
                            case .empty:
                                ProgressView()
                            case .success(let image):
                                image
                                    .resizable()
                                    .scaledToFill()
                                    .cornerRadius(15)
                                    .frame(width: 150, height: 180)
                            case .failure(_):
                                NoImageFoundView()
                            @unknown default:
                                EmptyView()
                            }
                        }.padding(.vertical, 25)
                    }
                }
            }
            
        }
        .onAppear {
            viewModel.fetchFavorites()
        }
    }
}

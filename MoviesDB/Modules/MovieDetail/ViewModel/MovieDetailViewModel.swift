//
//  MovieDetailViewModel.swift
//  MoviesDB
//
//  Created by Elif Parlak on 14.01.2025.
//

import Foundation

final class MovieDetailViewModel: ObservableObject {
    @Published var isFavorite: Bool = false
    private let userDefaultsManager: UserDefaultsManager
    
    init(userDefaultsManager: UserDefaultsManager) {
        self.userDefaultsManager = userDefaultsManager
    }
    
    func saveOrRemoveFavorite(with movie: Movie) {
        var favorites: [Movie] = userDefaultsManager.get([Movie].self, forKey: .favoriteMovies) ?? []
        
        if let index = favorites.firstIndex(where: { $0.id == movie.id }) {
            favorites.remove(at: index)
            isFavorite = false // Update state when removed
            print("Removed \(movie.title)")
        } else {
            favorites.append(movie)
            isFavorite = true // Update state when added
            print("Added \(movie.title)")
        }
        
        userDefaultsManager.save(favorites, forKey: .favoriteMovies)
    }
    
    func checkIfFavorite(movie: Movie) {
        let favorites: [Movie] = userDefaultsManager.get([Movie].self, forKey: .favoriteMovies) ?? []
        isFavorite = favorites.contains(where: { $0.id == movie.id })
    }
}




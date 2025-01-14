//
//  FavoritesViewModel.swift
//  MoviesDB
//
//  Created by Elif Parlak on 12.01.2025.
//

import Foundation

final class FavoritesViewModel: ObservableObject {
    @Published var favorites: [Movie] = []
    private let userDefaults: UserDefaultsManager
    
    init(userDefaults: UserDefaultsManager) {
        self.userDefaults = userDefaults
    }
    
    func fetchFavorites() {
        guard let movies = userDefaults.get([Movie].self, forKey: .favoriteMovies) else {
            print("Favorites Movies is empty")
            return
        }
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            self.favorites = movies
        }
    }
}

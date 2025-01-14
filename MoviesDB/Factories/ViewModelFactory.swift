//
//  ViewModelFactory.swift
//  MoviesDB
//
//  Created by Elif Parlak on 12.01.2025.
//

import Foundation

protocol ViewModelFactoryProtocol {
    func createHomeViewModel() -> HomeViewModel
    func createDiscoversViewModel() -> DiscoverViewModel
    func createFavoritesViewModel() -> FavoritesViewModel
    func createMovieDetailViewModel() -> MovieDetailViewModel
}

class ViewModelFactory: ViewModelFactoryProtocol {
    private let networkService: NetworkServiceProtocol
    private let userDefaultsManager: UserDefaultsManager
    
    init(networkService: NetworkServiceProtocol, userDefaultsManager: UserDefaultsManager) {
        self.networkService = networkService
        self.userDefaultsManager = userDefaultsManager
    }
    
    func createHomeViewModel() -> HomeViewModel {
        return HomeViewModel(networkService: networkService)
    }
    
    func createDiscoversViewModel() -> DiscoverViewModel {
        return DiscoverViewModel(networkService: networkService)
    }
    
    func createFavoritesViewModel() -> FavoritesViewModel {
        return FavoritesViewModel(userDefaults: userDefaultsManager)
    }
    
    func createMovieDetailViewModel() -> MovieDetailViewModel {
        return MovieDetailViewModel(userDefaultsManager: userDefaultsManager)
    }
}

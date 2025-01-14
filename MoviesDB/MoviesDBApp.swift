//
//  MoviesDBApp.swift
//  MoviesDB
//
//  Created by Elif Parlak on 12.01.2025.
//

import SwiftUI

@main
struct MoviesDBApp: App {
    private let viewModelFactory: ViewModelFactoryProtocol
    @StateObject private var router = RouterManager()
    private let userDefaultsManager = UserDefaultsManager.shared
    init() {
        let networkService = NetworkService.shared
        self.viewModelFactory = ViewModelFactory(networkService: networkService, userDefaultsManager: userDefaultsManager)
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $router.navigationPath) {
                BottomNavBar(factory: viewModelFactory)
                    .navigationDestination(for: RouterManager.Destination.self) { destination in
                        destinationView(for: destination)
                    }
            }
            .preferredColorScheme(.dark)
            .environmentObject(router)
        }
    }
    
    @ViewBuilder
    private func destinationView(for destination: RouterManager.Destination) -> some View {
        switch destination {
        case .home:
            HomeView(viewModel: viewModelFactory.createHomeViewModel())
        case .search:
            DiscoverView(viewModel: viewModelFactory.createDiscoversViewModel())
        case .movieDetail(let movie):
            MovieDetailView(viewModel: viewModelFactory.createMovieDetailViewModel(), movie: movie)
        case .favorites:
            FavoritesView(viewModel: viewModelFactory.createFavoritesViewModel())
        }
    }
}


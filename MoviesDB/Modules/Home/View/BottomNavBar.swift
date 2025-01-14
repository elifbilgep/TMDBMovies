//
//  ContentView.swift
//  MoviesDB
//
//  Created by Elif Parlak on 12.01.2025.
//

import SwiftUI

struct BottomNavBar: View {
    private let factory: ViewModelFactoryProtocol
    
    init(factory: ViewModelFactoryProtocol) {
        self.factory = factory
    }
    var body: some View {
        TabView {
            HomeView(viewModel: factory.createHomeViewModel())
                .tabItem {
                    NavBarItem(image: "house.fill", title: "Home")
                }
            DiscoverView(viewModel: factory.createDiscoversViewModel())
                .tabItem {
                    NavBarItem(image: "magnifyingglass", title: "Discover")
                }
            FavoritesView(viewModel: factory.createFavoritesViewModel())
                .tabItem {
                    NavBarItem(image: "heart.fill", title: "Favorites")
                }
        }
        .accentColor(.white)
    }
}

struct NavBarItem: View {
    var image: String
    var title: String
    
    var body: some View {
        VStack {
            Image(systemName: image)
            Text(title)
        }.opacity(0.8)
    }
}

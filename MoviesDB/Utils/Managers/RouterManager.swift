//
//  RouterManager.swift
//  MoviesDB
//
//  Created by Elif Parlak on 13.01.2025.
//

import SwiftUI

final class RouterManager: ObservableObject {
    @Published var navigationPath = NavigationPath()
    
    enum Destination: Codable, Hashable {
        case home
        case search
        case movieDetail(Movie)
        case favorites
    }
    
    func navigateTo(to destination: Destination) {
        navigationPath.append(destination)
    }
    
    func navigateBack() {
        navigationPath.removeLast()
    }
    
    func navigateToRoot() {
        navigationPath.removeLast(navigationPath.count)
    }
    
    func isBackAvailable() -> Bool {
        return !navigationPath.isEmpty
    }
}

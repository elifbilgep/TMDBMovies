//
//  HomeViewModel.swift
//  MoviesDB
//
//  Created by Elif Parlak on 12.01.2025.
//

import Foundation


final class HomeViewModel: ObservableObject {
    @Published var nowPlayingMovies: [Movie] = []
    @Published var upcomingMovies: [Movie] = []
    @Published var topRatedMovies: [Movie] = []
    @Published var errorMessage: String = ""
    @Published var showcaseMovie: Movie?
    private let networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    func fetchNowPlaying() async {
        do {
            let result: MovieData = try await networkService.fetch(endpoint: .nowPlaying, page: 1)
            DispatchQueue.main.async { [weak self] in
                guard let self else { return }
                self.nowPlayingMovies = result.results
            }
        } catch {
            errorMessage = error.localizedDescription
            print(error)
        }
    }
    
    func fetchUpcoming() async {
        do {
            let result: MovieData = try await networkService.fetch(endpoint: .upcoming, page: 1)
            DispatchQueue.main.async { [weak self] in
                guard let self else { return }
                self.upcomingMovies = result.results
            }
        } catch {
            errorMessage = error.localizedDescription
            print(error)
        }
    }
    
    func fetchTopRated() async {
        do {
            let result: MovieData = try await networkService.fetch(endpoint: .topRated, page: 1)
            DispatchQueue.main.async { [weak self] in
                guard let self else { return }
                self.topRatedMovies = result.results
                self.topRatedMovies.remove(at: 1)
                showcaseMovie = topRatedMovies[1]
            }
        } catch {
            errorMessage = error.localizedDescription
            print(error)
        }
    }
}

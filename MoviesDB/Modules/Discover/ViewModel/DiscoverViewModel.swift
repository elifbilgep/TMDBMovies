//
//  DiscoverViewModel.swift
//  MoviesDB
//
//  Created by Elif Parlak on 14.01.2025.
//

import Foundation

final class DiscoverViewModel: ObservableObject {
    private let networkService: NetworkServiceProtocol
    @Published var discovers: [Movie] = []
    @Published var isLoading = false
    private var currentPage = 1
    private var canLoadMorePages = true
    
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
        Task {
           await fetchDiscover()
        }
    }
    
    func fetchDiscover() async {
        guard !isLoading else { return }
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            self.isLoading = true
        }
        
        do {
            let results: MovieData = try await networkService.fetch(endpoint: .discover, page: currentPage)
            DispatchQueue.main.async { [weak self] in
                guard let self else { return }
                self.discovers = results.results
                isLoading = false
            }
        } catch {
            DispatchQueue.main.async { [weak self] in
                guard let self else { return }
                isLoading = false
            }
            print(error)
        }
    }
    
    func fetchNextPage() async {
        guard canLoadMorePages, !isLoading else { return }
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            self.isLoading = true
        }
        
        currentPage += 1
        
        let newMovies = await fetchMovies(page: currentPage)
        if newMovies.isEmpty {
            DispatchQueue.main.async {
                self.canLoadMorePages = false
                self.isLoading = false
            }
        } else {
            DispatchQueue.main.async { [weak self] in
                guard let self else { return }
                self.discovers.append(contentsOf: newMovies)
                self.isLoading = false
            }
        }
    }
    
    func searchMovies(query: String) async {
        guard !isLoading else { return }
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            isLoading = true
        }
        do {
            let results: MovieData = try await networkService.searchMovies(query: query, page: 1)
            DispatchQueue.main.async { [weak self] in
                guard let self else { return }
                self.discovers = results.results
                self.isLoading = false
            }
        } catch {
            print(error)
        }
    }
    
    private func fetchMovies(page: Int) async -> [Movie]  {
        do {
            let moreMovies: MovieData = try await networkService.fetch(endpoint: .discover, page: currentPage)
            if moreMovies.results.isEmpty {
                canLoadMorePages = false
                return []
            } else {
                return moreMovies.results
            }
        } catch {
            print("Error occured: \(error)")
        }
        return []
    }
    
}

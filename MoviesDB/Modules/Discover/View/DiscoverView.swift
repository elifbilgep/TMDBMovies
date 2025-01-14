//
//  SearchView.swift
//  MoviesDB
//
//  Created by Elif Parlak on 12.01.2025.
//

import SwiftUI

struct DiscoverView: View {
    @StateObject private var viewModel: DiscoverViewModel
    @EnvironmentObject private var router: RouterManager
    @State private var searchText: String = ""
    
    init(viewModel: DiscoverViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    private let columns = [
        GridItem(.flexible()), // First column
        GridItem(.flexible())  // Second column
    ]
    var body: some View {
        ScrollView {
            VStack(spacing: 30) {
                searchBar
                    .padding(.bottom, 10)
                LazyVGrid(columns: columns) {
                    ForEach(viewModel.discovers, id: \.id) { movie in
                        AsyncImage(url: movie.fullPosterURL){ phase in
                            switch phase {
                            case .empty:
                                ProgressView()
                            case .success(let image):
                                image
                                    .resizable()
                                    .scaledToFill()
                                    .cornerRadius(15)
                                    .frame(width: 150, height: 170)
                                  
                                
                            case .failure(_):
                                NoImageFoundView()
                                    .padding(.bottom, 10)
                            @unknown default:
                                EmptyView()
                            }
                        }
                        .padding(.bottom, 70)
                        .onTapGesture {
                            router.navigateTo(to: .movieDetail(movie))
                        }
                        
                        .onAppear {
                            if movie == viewModel.discovers.last {
                                Task {
                                    await viewModel.fetchNextPage()
                                }
                            }
                        }
                        
                        if viewModel.isLoading {
                            ProgressView()
                                .frame(maxWidth: .infinity)
                        }
                    }
                }
            }
        }
    }
    
    @ViewBuilder
    private var searchBar: some View {
        HStack {
            TextField("Search a movie...", text: $searchText)
                .padding(.vertical, 10)
                .padding(.horizontal, 16)
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
                .overlay {
                    HStack {
                        Spacer()
                        Image(systemName: "x.circle.fill")
                            .foregroundStyle(.gray)
                            .onTapGesture {
                                searchText = ""
                                Task {
                                    await viewModel.fetchDiscover()
                                }
                            }
                    }
                    .padding()
                }
            Button {
                Task {
                    await viewModel.searchMovies(query: searchText)
                }
                
            } label: {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.gray)
            }
        }
        
        .padding(.horizontal)
        .padding(.vertical, 8)
    }
    
}

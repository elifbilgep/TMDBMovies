//
//  HomeView.swift
//  MoviesDB
//
//  Created by Elif Parlak on 12.01.2025.
//

import SwiftUI

struct HomeView: View {
    @StateObject var viewModel: HomeViewModel
    @EnvironmentObject private var routerManager: RouterManager
    init(viewModel: HomeViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        ScrollView {
            VStack {
                topView
                topRatedView
                popular
            }
        }
        .scrollIndicators(.hidden)
        .onAppear {
            Task {
                await viewModel.fetchTopRated()
                await viewModel.fetchUpcoming()
            }
        }
    }
    
    @ViewBuilder
    private var topView: some View {
        ZStack(alignment: .center) {
            Color.black
            AsyncImage(url: viewModel.showcaseMovie?.fullPosterURL) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                        .frame(width: 100, height: 150)
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()
                        .overlay {
                            LinearGradient(colors: [ .clear, .black ], startPoint: .top, endPoint: .bottom)
                        }
                        .frame(
                            width: UIScreen.screenWidth,
                            height: 280
                        )
                case .failure(_):
                    Image(systemName: "exclamationmark.square.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 150)
                        .foregroundColor(.gray)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                @unknown default:
                    EmptyView()
                }
            }
               
            HStack {
                HStack(spacing: 16) {
                    Button(action: {
                        print("Play tapped")
                    }) {
                        HStack {
                            Image(systemName: "play.fill")
                            Text("Play")
                        }
                    }
                    .modifier(ButtonStyleModifier(style: .filled))
                    
                    Button(action: {
                        print("Details tapped")
                    }) {
                        Text("Details")
                    }
                    .modifier(ButtonStyleModifier(style: .outlined))
                }
            }
            .offset(y: 230)
        }
        .frame(
            width: UIScreen.main.bounds.width,
            height: 300
        )
    }
    
    @ViewBuilder
    private var topRatedView: some View {
        VStack {
            HStack {
                Text("Top Rated")
                    .font(.system(size: 24, weight: .semibold))
                Spacer()
                Text("See all")
                    .font(.system(size: 16, weight: .bold))
                    .foregroundStyle(.gray)
            }
            ScrollView(.horizontal) {
                HStack {
                    ForEach(viewModel.topRatedMovies, id: \.id) { movie in
                        MovieCard(movie: movie)
                            .onTapGesture {
                                routerManager.navigateTo(to: .movieDetail(movie))
                            }
                    }
                }
                
            }
            .scrollIndicators(.hidden)
        }
        .padding(.top, 120)
        .padding(.horizontal)
    }
    
    @ViewBuilder
    private var popular: some View {
        VStack {
            HStack {
                Text("Popular")
                    .font(.system(size: 24, weight: .semibold))
                Spacer()
                Text("See all")
                    .font(.system(size: 16, weight: .bold))
                    .foregroundStyle(.gray)
            }
            ScrollView(.horizontal) {
                HStack {
                    ForEach(viewModel.upcomingMovies, id: \.id) { movie in
                        MovieCard(movie: movie)
                            .onTapGesture {
                                routerManager.navigateTo(to: .movieDetail(movie))
                            }
                    }
                }
            }
            .scrollIndicators(.hidden)
        }
        .padding(.top, 10)
        .padding(.horizontal)
    }
}

struct MovieCard: View {
    var movie: Movie
    
    var body: some View {
        AsyncImage(url: movie.fullPosterURL) { phase in
            switch phase {
            case .empty:
                ProgressView()
                    .frame(width: 100, height: 150)
            case .success(let image):
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: 120, height: 180)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                    .modifier(BlackGradientModifier())
                
            case .failure:
                NoImageFoundView()
            @unknown default:
                EmptyView()
            }
        }
        
    }
}



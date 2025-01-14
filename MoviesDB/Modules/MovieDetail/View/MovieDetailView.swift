//
//  MovieDetail.swift
//  MoviesDB
//
//  Created by Elif Parlak on 13.01.2025.
//

import SwiftUI

struct MovieDetailView: View {
    @EnvironmentObject private var router: RouterManager
    @StateObject private var viewModel: MovieDetailViewModel
    private let movie: Movie
    
    init(viewModel: MovieDetailViewModel, movie: Movie) {
        _viewModel = StateObject(wrappedValue: viewModel)
        self.movie = movie
    }
    
    var body: some View {
        ScrollView {
            VStack {
                ZStack(alignment: .top) {
                    imageView
                    topBarView
                }
                .frame(height: 300)
                imagePosterView
                    .padding(.top, -150)
                VStack(alignment: .leading) {
                    Text(movie.title ?? "No movie name")
                        .font(.system(size: 24, weight: .bold))
                    Text(movie.overview)
                }
                .padding()
                
            }
        }
        .navigationBarBackButtonHidden()
        .ignoresSafeArea()
        .onAppear {
            viewModel.checkIfFavorite(movie: movie)
        }
    }
    
    @ViewBuilder
    private var topBarView: some View {
        HStack {
            Circle()
                .modifier(CircleModifier())
                .overlay {
                    Image(systemName: "arrow.backward")
                }
                .onTapGesture {
                    router.navigateBack()
                }
            Spacer()
            Circle()
                .modifier(CircleModifier())
                .overlay {
                    Image(systemName: "ellipsis")
                }
        }
        .padding(.horizontal)
        .padding(.top, 60)
    }
    
    @ViewBuilder
    private var imageView: some View {
        AsyncImage(url: movie.fullBackdropURL) { phase in
            switch phase {
            case .empty:
                ProgressView()
                    .frame(width: UIScreen.main.bounds.width, height: 300)
            case .success(let image):
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: UIScreen.main.bounds.width, height: 300)
                    .clipped()
            case .failure(_):
                NoImageFoundView()
            @unknown default:
                EmptyView()
            }
        }
    }
    
    @ViewBuilder
    private var imagePosterView: some View {
        HStack(alignment: .top) {
            AsyncImage(url: movie.fullPosterURL) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                        .frame(width: 120, height: 180)
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: 120, height: 180)
                        .cornerRadius(15)
                        .shadow(radius: 5)
                        .padding()
                case .failure:
                    NoImageFoundView()
                @unknown default:
                    EmptyView()
                }
            }
            
            Spacer()
            VStack {
                Spacer()
                HStack {
                    Text(movie.releaseDate!.toFormattedDate()!)
                        .foregroundStyle(.gray)
                        .font(.system(size: 14))
                    Spacer()
                    Image(systemName: "arrowshape.up.fill")
                        .foregroundStyle(.green)
                    Text("10/\(Int(movie.voteAverage))")
                    
                    Image(systemName: viewModel.isFavorite ? "heart.fill" : "heart")
                        .foregroundStyle(viewModel.isFavorite ? .red : .gray)
                        .onTapGesture {
                            viewModel.saveOrRemoveFavorite(with: movie)
                        }
                }
            }
        }
        .padding()
    }
    
}

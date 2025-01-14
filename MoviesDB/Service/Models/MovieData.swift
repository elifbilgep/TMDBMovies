//
//  MovieData.swift
//  MoviesDB
//
//  Created by Elif Parlak on 13.01.2025.
//

import Foundation

// MARK: - MovieData
struct MovieData: Codable {
    let dates: Dates?
    let page: Int
    let results: [Movie]
    let totalPages, totalResults: Int
    
    enum CodingKeys: String, CodingKey {
        case dates, page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

struct Dates: Codable {
    let maximum, minimum: String
}

// MARK: - Result
struct Movie: Codable, Equatable, Hashable, Identifiable {
    let adult: Bool
    let backdropPath: String?
    let genreIDS: [Int]
    let id: Int
    let originalLanguage: String
    let originalTitle, overview: String
    let popularity: Double
    let posterPath, releaseDate, title: String?
    let video: Bool
    let voteAverage: Double
    let voteCount: Int
    
    var fullPosterURL: URL? {
        URL(string: "https://image.tmdb.org/t/p/w500\(posterPath ?? "")")
    }
    var fullBackdropURL: URL? {
        URL(string: "https://image.tmdb.org/t/p/w500\(backdropPath ?? "")")
    }
    
    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case genreIDS = "genre_ids"
        case id
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title, video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}


//
//  APIEndpoint.swift
//  HarryPotter
//
//  Created by Elif Parlak on 29.12.2024.
//

import Foundation

enum APIEndpoint {
    static let baseURL = "https://api.themoviedb.org/3"
    
    case topRated
    case popular
    case upcoming
    case nowPlaying
    case discover
    case movieDetail(String)
    case search(String)
    
    var path: String {
        switch self {
        case .topRated:
            "/movie/top_rated"
        case .popular:
            "/movie/popular"
        case .upcoming:
            "/movie/upcoming"
        case .nowPlaying:
            "/movie/now_playing"
        case .movieDetail(let movieId):
            "/movie/\(movieId)/credits"
        case .discover:
            "/discover/movie"
        case .search:
            "/search/movie"
        }
    }
    
    var url: URL? {
        return URL(string: APIEndpoint.baseURL + path)
    }
}

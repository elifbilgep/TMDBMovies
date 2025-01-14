//
//  NetworkError.swift
//  HarryPotter
//
//  Created by Elif Parlak on 29.12.2024.
//

import Foundation

// MARK: - NetworkError Enum
enum NetworkError: Error, LocalizedError {
    case invalidURL
    case invalidResponse
    case httpError(Int)
    case decodingError(String)
    case networkError(String)

    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "The URL provided is invalid."
        case .invalidResponse:
            return "The server response was invalid."
        case .httpError(let statusCode):
            return "HTTP Error: Received status code \(statusCode)."
        case .decodingError(let message):
            return "Decoding Error: \(message)"
        case .networkError(let message):
            return "Network Error: \(message)"
        }
    }
}

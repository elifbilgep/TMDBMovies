//
//  NetworkService.swift
//  HarryPotter
//
//  Created by Elif Parlak on 29.12.2024.
//

import Foundation

protocol NetworkServiceProtocol {
    func fetch<T: Decodable>(endpoint: APIEndpoint, page: Int) async throws -> T
    func searchMovies(query: String, page: Int) async throws -> MovieData
}

class NetworkService: NetworkServiceProtocol {
    static let shared = NetworkService()
    private let cache = NSCache<NSString, NSData>()
    
    private init() {}

    private let apiKey = Constants.apiKey

    func fetch<T: Decodable>(endpoint: APIEndpoint, page: Int) async throws -> T {
        guard let url = endpoint.url else {
            throw NetworkError.invalidURL
        }

        let finalURL = try constructURL(url: url, page: page)
        
        if let cachedData = cache.object(forKey: finalURL.absoluteString as NSString) {
            do {
                let decodedData = try JSONDecoder().decode(T.self, from: cachedData as Data)
                return decodedData
            } catch {
                throw NetworkError.decodingError("Failed to decode cached response: \(error.localizedDescription)")
            }
        }
        
        let request = createRequest(url: finalURL)

        return try await performRequest(request: request, cacheKey: finalURL.absoluteString)
    }

    func searchMovies(query: String, page: Int) async throws -> MovieData {
        guard let url = APIEndpoint.search(query).url else {
            throw NetworkError.invalidURL
        }

        let finalURL = try constructURL(url: url, query: query, page: page)
        let request = createRequest(url: finalURL)

        return try await performRequest(request: request, cacheKey: finalURL.absoluteString)
    }

    // MARK: - Helper Methods
    private func constructURL(url: URL, query: String? = nil, page: Int) throws -> URL {
        var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)
        var queryItems = [
            URLQueryItem(name: "api_key", value: apiKey),
            URLQueryItem(name: "language", value: "en-US"),
            URLQueryItem(name: "page", value: "\(page)")
        ]

        if let query = query {
            queryItems.append(URLQueryItem(name: "query", value: query))
        }

        urlComponents?.queryItems = queryItems

        guard let finalURL = urlComponents?.url else {
            throw NetworkError.invalidURL
        }

        return finalURL
    }

    //MARK: Create request
    private func createRequest(url: URL) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "accept")
        return request
    }

    //MARK: Perform Request
    private func performRequest<T: Decodable>(request: URLRequest, cacheKey: String) async throws -> T {
        do {
            let (data, response) = try await URLSession.shared.data(for: request)

            guard let httpResponse = response as? HTTPURLResponse else {
                throw NetworkError.invalidResponse
            }

            guard (200...299).contains(httpResponse.statusCode) else {
                throw NetworkError.httpError(httpResponse.statusCode)
            }

            cache.setObject(data as NSData, forKey: cacheKey as NSString)
            
            do {
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                return decodedData
            } catch {
                throw NetworkError.decodingError("Failed to decode response: \(error.localizedDescription)")
            }
        } catch {
            if let urlError = error as? URLError {
                throw NetworkError.networkError(urlError.localizedDescription)
            }
            throw error
        }
    }
}

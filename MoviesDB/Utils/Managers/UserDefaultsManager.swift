//
//  UserDefaultsManager.swift
//  MoviesDB
//
//  Created by Elif Parlak on 14.01.2025.
//

import Foundation

final class UserDefaultsManager {
    static let shared = UserDefaultsManager()
    
    private init() { }
    
    //MARK: Keys
    enum Keys: String {
        case favoriteMovies = "favoriteMovies"
    }
    
    //MARK: Generic Methods
    func save<T: Codable>(_ object: T, forKey key: UserDefaultsManager.Keys) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(object) {
            UserDefaults.standard.set(encoded, forKey: key.rawValue)
        }
    }
    
    func get<T: Codable>(_ type: T.Type, forKey key: UserDefaultsManager.Keys) -> T? {
        guard let data = UserDefaults.standard.data(forKey: key.rawValue) else { return nil }
        let decoder = JSONDecoder()
        return try? decoder.decode(type, from: data)
    }
    
    func remove(forKey key: String) {
        UserDefaults.standard.removeObject(forKey: key)
    }
}

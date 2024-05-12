//
//  PersistanceManager.swift
//  AppcentNewsApp
//
//  Created by abdullah on 11.05.2024.
//

import Foundation

enum PersistenceActionType {
    case add, remove
}

enum PersistanceManager{
    static private let defaults = UserDefaults.standard
    enum Keys{
        static let favorites = "favorites"
    }
    
    static func updeteWith(favorite: Favorite, actionType: PersistenceActionType, completed: @escaping(ANError?)->()){
        
            retrieveFavorites { result in
                switch result {
                case .success(var favorites):
                    switch actionType {
                    case .add:
                        guard !favorites.contains(where: { $0.id == favorite.id }) else {
                            completed(.alreadyInFavorites)
                            return
                        }
                        favorites.append(favorite)
                        
                    case .remove:
                        favorites.removeAll { $0.id == favorite.id }
                    }
                    
                    if let error = save(favorites: favorites) {
                        completed(error)
                    } else {
                        completed(nil)
                    }
                    
                case .failure(let failure):
                    completed(failure)
                }
            }
        }

        
        
    
    
    
    
    
    static func retrieveFavorites(completed: @escaping(Result<[Favorite], ANError>)->()) {
        
        guard let favoriteData = defaults.object(forKey: Keys.favorites) as? Data else {
            completed(.success([]))
            return
        }
        
        do {
            let decoder = JSONDecoder()
            let favorites = try decoder.decode([Favorite].self, from: favoriteData)
            
            completed(.success(favorites))
        }
        catch{
            completed(.failure(.unableToFavorite))
        }
    }
    
    static func save(favorites: [Favorite]) -> ANError? {
        do {
            
            let encoder = JSONEncoder()
            let encodedFavorites = try encoder.encode(favorites)
            defaults.set(encodedFavorites, forKey: Keys.favorites)
            return nil
            
        }catch {
            return .unableToFavorite
        }
        
    }
    
    
    
    
}

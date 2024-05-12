//
//  Faavorite.swift
//  AppcentNewsApp
//
//  Created by abdullah on 12.05.2024.
//

import Foundation

struct Favorite: Hashable, Codable{
    static func == (lhs: Favorite, rhs: Favorite) -> Bool {
        return lhs.id == rhs.id
    }
    
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    init(id: UUID = UUID(), article: Article? = nil) {
        self.id = id
        self.article = article
    }
    
    
    var id = UUID()
    var article:Article?
}

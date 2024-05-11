//
//  News.swift
//  AppcentNewsApp
//
//  Created by abdullah on 11.05.2024.
//

import Foundation

// MARK: News
struct News: Codable {
    let status: String?
    let totalResults: Int?
    var articles: [Article]?
}

struct Article: Codable {
    
   
   
    
    var source: Source?
    let author: String?
    let title: String?
    let description: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String?
    let content: String?
    
    var _author: String { author ?? "Not found" }
    var _title: String { title ?? "Not found" }
    var _description: String { description ?? "Not found" }
    var _url: String { url ?? "Not found" }
    var _urlToImage: String { urlToImage ?? "Not found" }
    var _publishedAt: String { publishedAt ?? "Not found" }
    var _content: String { content ?? "Not found" }
}


struct Source: Codable {
    let id         :String?
    let name       :String?
}

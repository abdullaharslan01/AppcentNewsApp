//
//  NetworkManager.swift
//  AppcentNewsApp
//
//  Created by abdullah on 11.05.2024.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    private init() {}
    
    
    func getNews(newsKeyword: String, page: Int, completed: @escaping (Result<News?,ANError>)->()){
        
        let endpoint  = ANApiUrls.baseURL + "?q=\(newsKeyword)&page=\(page)&apiKey=\(ANApiUrls.apiKEY)"
        
        guard let url = URL(string: endpoint) else {
            completed(.failure(.invalidKeyword))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let _ = error {
                completed(.failure(.unableToComplete))
                    return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidKeyword))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidResponse))
                return
            }
            
            do {
                
                let decoder  = JSONDecoder()
                
                let articles = try decoder.decode(News.self, from: data)
                
                print(articles.articles?[0] ?? "Emty")
                print(articles.totalResults ?? "0")
                completed(.success(nil))
                
                
            }catch {
                completed(.failure(.invalidData))
            }
            
        }
        
        task.resume()
        
        
    }
    
    
}

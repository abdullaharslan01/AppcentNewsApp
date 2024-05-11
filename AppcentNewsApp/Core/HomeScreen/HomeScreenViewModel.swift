//
//  HomeNewsViewController.swift
//  AppcentNewsApp
//
//  Created by abdullah on 11.05.2024.
//

import Foundation


protocol HomeScreenViewModelDelegate{
    var delegate: HomeScreenDelegate? {get set}
    func getArticles(keyword:String)
    func articleNumberOfItemsInSection()->Int
    func getArticleItem(at index:Int)-> Article?
}


final class HomeScreenViewModel{
    weak var delegate:  HomeScreenDelegate?
    private var page: Int           = 1
    private var articles: [Article]  = []
    var isSearching = false
}




extension HomeScreenViewModel: HomeScreenViewModelDelegate{
    func getArticleItem(at index: Int) -> Article? {
        
        guard index >= 0 && index < articles.count else{return nil}
        return articles[index]
    }
    
    
    
    func articleNumberOfItemsInSection() -> Int {
        return self.articles.count
    }
    
    
    
    
    func getArticles(keyword: String) {
    
        NetworkManager.shared.getNews(newsKeyword: keyword, page: 1) {[weak self] result in
            guard let self = self else {return}
            
            switch result {
                
            case .success(let news):
                
                guard let newArticles = news?.articles else {return}
                
                self.articles = newArticles
                
                delegate?.reloadTableView()
                
            case .failure(let failure):
                print(failure.rawValue)
                break
            }
        }
        
        
        
        
    }
    
    
    func viewDidload(){
        delegate?.configureView()
        delegate?.configureTableView()
        delegate?.configureSearchBar()
        
    }
    
}

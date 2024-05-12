//
//  HomeNewsViewController.swift
//  AppcentNewsApp
//
//  Created by abdullah on 11.05.2024.
//

import Foundation


protocol HomeScreenViewModelDelegate{
    var  delegate: HomeScreenDelegate? {get set}
    func getArticles()
    func articleNumberOfItemsInSection()->Int
    func getArticleItem(at index:Int)-> Article?
    func nextPage()
    func resetPageNumber()
    func updateSearchKeyword(keyword: String)
    
}


final class HomeScreenViewModel{
    weak var delegate:  HomeScreenDelegate?
    private var page: Int            = 1
    private var searchKeyword        = ""
    private var articles: [Article]  = []
    private var totalPageNumber      = 1
    var isSearching = false
}




extension HomeScreenViewModel: HomeScreenViewModelDelegate{
 
    
    func updateSearchKeyword(keyword: String) {
        
        self.searchKeyword = keyword
        }
    
    func nextPage() {
        page += 1
        getArticles()
    }
    
    func resetPageNumber() {
        page            = 1
        totalPageNumber = 1
    }
    
    func getArticleItem(at index: Int) -> Article? {
        
        guard index >= 0 && index < articles.count else{return nil}
        return articles[index]
    }
    
    
    
    func articleNumberOfItemsInSection() -> Int {
        return self.articles.count
    }
    
    
    
    
    
    func getArticles() {
    
        
        if page <= totalPageNumber {
            delegate?.dismissEmtyStateView()
            delegate?.showLoadingView()

            
            NetworkManager.shared.getNews(newsKeyword: searchKeyword, page: page) {[weak self] result in
                guard let self = self else {return}
                
                switch result {
                    
                case .success(let news):
                    
                    guard let news = news, let totalResult = news.totalResults, let articles = news.articles  else {return}
                    self.totalPageNumber = totalResult / 100
                    
                    if self.isSearching {
                        
                        self.articles.removeAll()
                    }
                    
                    
                    self.isSearching = false
                    self.articles.append(contentsOf: articles)
                    delegate?.dismissLoadingView()
                    delegate?.reloadTableView()
                    
                case .failure(let failure):
                    self.delegate?.showAlertMessage(title: ANTexts.error, message: failure.rawValue)
                    delegate?.dismissLoadingView()

                    break
                }
                
            }
            
        }
        else{
            delegate?.dismissLoadingView()
            self.delegate?.showAlertMessage(title: ANTexts.warning, message: ANTexts.outOfNewsText)
           

        }
        
        
        
        
        
    }
    
    
    func viewDidload(){
        delegate?.configureView()
        delegate?.configureTableView()
        delegate?.configureSearchBar()
        delegate?.showEmtyStateView(message: ANTexts.emtyPageText)
        
    }
    
}

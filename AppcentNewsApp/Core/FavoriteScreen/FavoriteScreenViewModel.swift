//
//  FavoriteScreenViewModel.swift
//  AppcentNewsApp
//
//  Created by abdullah on 12.05.2024.
//

import Foundation

protocol FavoriteScreenViewModelDelegate{
    var delegate: FavoriteScreenDelegate? {get set}
    func viewDidload()
    func getArticleItem(at index:Int)->Article?
    func articleNumberOfItemsInSection()-> Int
    func retriveFavorites()
    func reloadTableView()
}

final class FavoriteScreenViewModel{
    weak var delegate:  FavoriteScreenDelegate?
    var favoriteArticles:[Favorite] = []
}

extension FavoriteScreenViewModel: FavoriteScreenViewModelDelegate{
    func retriveFavorites() {
        delegate?.retrieveFavorites()
    }
    
    func reloadTableView(){
        delegate?.reloadTableView()
    }
   
    
    func getArticleItem(at index: Int) -> Article? {
        
        guard index >= 0 && index < favoriteArticles.count else{return nil}
        return self.favoriteArticles[index].article


    }
    
    
    
    func articleNumberOfItemsInSection() -> Int {
        return self.favoriteArticles.count
    }
    
    func viewDidload() {
        delegate?.vieewDidload()
        delegate?.configureTableView()
    }
    
    
  
    
    
}

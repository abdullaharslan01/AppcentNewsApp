//
//  DetailScreen.swift
//  AppcentNewsApp
//
//  Created by abdullah on 11.05.2024.
//

import UIKit

protocol DetailScreenViewModelDelegate{
    var delegate: DetailScreenDelegate? {get set}
    func viewDidLoad()
    func favoriteArticle(article: Article?)
}


final class DetailScreenViewModel {
    weak var delegate: DetailScreenDelegate?
    
    
}


extension DetailScreenViewModel: DetailScreenViewModelDelegate{
    func favoriteArticle(article: Article?) {
        guard let article = article else {return}
        
        PersistanceManager.updeteWith(favorite: Favorite(article: article), actionType: .add) {[weak self] error in
            guard let self = self else {return}
            
            guard let error = error else {
                delegate?.showAlertMessage(title: "Success!", messsage: "You have successfully favorited this new")
                
                return
            }
            
            delegate?.showAlertMessage(title: "Something went wrong", messsage: error.rawValue)
        }
    }
    
   
    
    func viewDidLoad() {
        delegate?.viewDidload()
        delegate?.configureViewDesign()
        delegate?.setUpView()
    }
    
    
   
    
    
}

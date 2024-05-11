//
//  HomeNewsViewController.swift
//  AppcentNewsApp
//
//  Created by abdullah on 11.05.2024.
//

import Foundation


protocol HomeScreenViewModelDelegate{
    var delegate: HomeScreenDelegate? {get set}
}


final class HomeScreenViewModel{
    weak var delegate:  HomeScreenDelegate?
    private var page: Int = 1
    private var articles: [Article] = []
    
}




extension HomeScreenViewModel: HomeScreenViewModelDelegate{
    
    func viewDidload(){
        delegate?.configureView()
        delegate?.configureTableView()
        delegate?.configureSearchBar()
        
    }
    
}

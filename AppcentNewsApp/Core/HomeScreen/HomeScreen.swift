//
//  HomeNewsVCViewController.swift
//  AppcentNewsApp
//
//  Created by abdullah on 11.05.2024.
//

import UIKit


protocol HomeScreenDelegate: AnyObject{
    func configureView()
    func configureTableView()
    func configureSearchBar()
    func nextPage()
    
}


final class HomeScreen: UIViewController {

    private let viewModel = HomeScreenViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.delegate = self
        viewModel.viewDidload()
       
        }
   
}


extension HomeScreen: HomeScreenDelegate{
    
    func configureTableView() {
        
        
        
    }
    
    func configureSearchBar() {
        
    }
    
    func nextPage() {
        
    }
    
    
    func configureView() {
        view.backgroundColor = .systemBackground
        title = "Appcent NewsApp"

    }
    
    
}

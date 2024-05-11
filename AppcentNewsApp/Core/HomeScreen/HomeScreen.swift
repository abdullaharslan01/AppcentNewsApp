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
    func reloadTableView()
    
}


final class HomeScreen: UIViewController{
   
    
  

    enum Section{case main}
    
    private let viewModel = HomeScreenViewModel()
    
    private let articlesTableView: UITableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.delegate = self
        viewModel.viewDidload()
       
        }
   
}


extension HomeScreen: HomeScreenDelegate{
    
   
    
    
    func reloadTableView() {
        DispatchQueue.main.async {
            self.articlesTableView.reloadData()
        }
    }
   
    
    
    func configureTableView() {
        articlesTableView.register(ANTableViewCell.self, forCellReuseIdentifier: ANTableViewCell.reuseID)
        view.addSubview(articlesTableView)
        articlesTableView.translatesAutoresizingMaskIntoConstraints = false
        articlesTableView.frame      = view.bounds
        articlesTableView.rowHeight  = 120
        articlesTableView.delegate   = self
        articlesTableView.dataSource = self
    }
    
    func configureSearchBar() {
        let searchController                    = UISearchController()
        searchController.searchBar.placeholder  = ANTexts.searchBarText
        navigationItem.searchController         = searchController
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.delegate     = self

       
        
    }
    
    func nextPage() {
        
    }
    
    
    func configureView() {
        view.backgroundColor = .systemBackground

    }
    
    
}

extension HomeScreen: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.articleNumberOfItemsInSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ANTableViewCell.reuseID, for: indexPath) as! ANTableViewCell
        guard let article = viewModel.getArticleItem(at: indexPath.row) else {return UITableViewCell()}
        
        cell.set(article: article)
        return cell
    }
    
   
    
    
}

extension HomeScreen: UISearchBarDelegate{
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let keyword = searchBar.text, !keyword.isEmpty else {
            return
        }
        
        viewModel.getArticles(keyword: keyword)
    }

       
    
    
}

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
    func showLoadingView()
    func dismissLoadingView()
    func showEmtyStateView(message:String)
    func dismissEmtyStateView()
    
}


final class HomeScreen: UIViewController{
   
    
  

    enum Section{case main}
    
    private let viewModel = HomeScreenViewModel()
    
    private let articlesTableView: UITableView = UITableView()
    private var articleSearchBar = UISearchController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.delegate = self
        viewModel.viewDidload()
       
        }
   
}


extension HomeScreen: HomeScreenDelegate{
    func dismissEmtyStateView() {
        ANDismissEmptyStateView()
    }
    
    func showEmtyStateView(message: String) {
        ANShowEmptyStateView(with: message, in: self.view)
    }
    
    func showLoadingView() {
        ANShowLoadingView()
    }
    
    func dismissLoadingView() {
        ANDismissLoadingView()
    }
    
    
    
    func reloadTableView() {
        
        DispatchQueue.main.async {
            self.articleSearchBar.dismiss(animated: true)
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
        articleSearchBar.searchBar.placeholder  = ANTexts.searchBarText
        articleSearchBar.obscuresBackgroundDuringPresentation = false
        articleSearchBar.searchBar.delegate     = self
        self.navigationItem.searchController         = articleSearchBar
       
        
    }
    
    func nextPage() {
        
    }
    
    
    func configureView() {
        view.backgroundColor = .systemBackground
        navigationItem.title = "Appcent NewsApp"

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
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let rotationTransform = CATransform3DTranslate(CATransform3DIdentity, -500, 10, 0)
        cell.layer.transform = rotationTransform
        cell.alpha = 0.5
        UIView.animate(withDuration: 1) {
            cell.layer.transform = CATransform3DIdentity
            cell.alpha = 1
        }
    }
   
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY         = scrollView.contentOffset.y
        
        let contentHeigh    = scrollView.contentSize.height
        
        let height          = scrollView.frame.size.height
        
        if offsetY > contentHeigh - height + 200 {
            
            viewModel.nextPage()
        }
    }
    
    
}

extension HomeScreen: UISearchBarDelegate{
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let keyword = searchBar.text, !keyword.isEmpty else {
            return
        }
        viewModel.isSearching = true
        viewModel.resetPageNumber()
        viewModel.updateSearchKeyword(keyword: keyword)
        viewModel.getArticles()
    }

       
    
    
}

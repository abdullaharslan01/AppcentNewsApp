//
//  FavoriteVC.swift
//  AppcentNewsApp
//
//  Created by abdullah on 11.05.2024.
//

import UIKit

protocol FavoriteScreenDelegate: AnyObject{
    func vieewDidload()
    func configureTableView()
    func retrieveFavorites()
    func reloadTableView()
    func showEmtyState(message: String)
    func dismissEmtypState()
}

final class FavoriteScreen: UIViewController {

    var viewModel         = FavoriteScreenViewModel()
    let favoriteTableView = UITableView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        viewModel.viewDidload()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.retriveFavorites()
        viewModel.checkFavoriteCountState()
       
        
    }

    

}

extension FavoriteScreen: FavoriteScreenDelegate{
  
    
    func dismissEmtypState() {
        self.ANDismissEmptyStateView()
    }
    
    func showEmtyState(message: String) {
        self.ANShowEmptyStateView(with: message, in: self.view)
    }
    
    func reloadTableView() {
        DispatchQueue.main.async { [weak self] in
            self?.favoriteTableView.reloadData()
        }
    }
    
    func retrieveFavorites() {
        
        PersistanceManager.retrieveFavorites { [weak self] result in
            switch result {
            case .success(let favorites):
                
                self?.viewModel.favoriteArticles = favorites
                self?.viewModel.reloadTableView()
                
                
                
                break
            case .failure(_):
                
                break
            }
        }
        
        
        
        
    }
    
    func configureTableView() {
        favoriteTableView.register(ANTableViewCell.self, forCellReuseIdentifier: ANTableViewCell.reuseID)
        view.addSubview(favoriteTableView)
        favoriteTableView.translatesAutoresizingMaskIntoConstraints = false
        favoriteTableView.frame      = view.bounds
        favoriteTableView.rowHeight  = 120
        favoriteTableView.delegate   = self
        favoriteTableView.dataSource = self
    }
    
    func vieewDidload() {
        view.backgroundColor = .systemBackground
        navigationItem.title =  ANTexts.favoriteScreenTitle

        retrieveFavorites()
        
    
    }
    
}

extension FavoriteScreen: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.articleNumberOfItemsInSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ANTableViewCell.reuseID, for: indexPath) as! ANTableViewCell
        guard let article = viewModel.getArticleItem(at: indexPath.row) else {return UITableViewCell()}
        
        cell.set(article: article)
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: ANTexts.removeButtonTitle) { [weak self] contextActuon, view, state in
            
            let favorite = self?.viewModel.favoriteArticles[indexPath.row]
            self?.viewModel.favoriteArticles.remove(at: indexPath.row)
            self?.favoriteTableView.deleteRows(at: [indexPath], with: .left)
            guard let favorite = favorite else {return}
            
            PersistanceManager.updeteWith(favorite: favorite, actionType: .remove) { error in
                if let error = error {
                    self?.ANShowAlert(title: ANTexts.somethingWrong, message: error.rawValue)
                }
                self?.viewModel.checkFavoriteCountState()
            }
        }
     
        
        
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let desVC = DetailScreen()
        tableView.deselectRow(at: indexPath, animated: true)
        desVC.article = viewModel.getArticleItem(at: indexPath.row)
        desVC.isFavorite = true
        navigationController?.pushViewController(desVC, animated: true)
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let rotationTransform = CATransform3DTranslate(CATransform3DIdentity, 0, -10, 0)
        cell.layer.transform = rotationTransform
        cell.alpha = 0
        UIView.animate(withDuration: 1) {
            cell.layer.transform = CATransform3DIdentity
            cell.alpha = 1
        }
        
    
        
    }
}

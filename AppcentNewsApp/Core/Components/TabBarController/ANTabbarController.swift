//
//  ANTabbarController.swift
//  AppcentNewsApp
//
//  Created by abdullah on 11.05.2024.
//

import UIKit

class ANTabbarController: UITabBarController {
    override func viewDidLoad() {
        configureTabBarController()
        UINavigationBar.appearance().tintColor = ANColors.mainColor
        UITabBar.appearance().tintColor = ANColors.mainColor
    }

    
    func createNavigationController(rootViewController: UIViewController, title: String, imageName: String, tag: Int) -> UINavigationController {
    rootViewController.title = title
    let navigationController = UINavigationController(rootViewController: rootViewController)
    let configuration        = UIImage.SymbolConfiguration(scale: .large)
    let image                = UIImage(systemName: imageName, withConfiguration: configuration)
    navigationController.tabBarItem = UITabBarItem(title: title, image: image, tag: tag)
    
    return navigationController
}
    
    func createTabViewControllers() -> [UIViewController] {
        let homeNC    = createNavigationController(rootViewController: HomeScreen(), title: "News", imageName: ANSymbols.home, tag: 0)
        let favoriteNC = createNavigationController(rootViewController: FavoriteVC(), title: "Favorites", imageName: ANSymbols.favorites, tag: 1)
       
       return [homeNC, favoriteNC]
       
        
   }
    func configureTabBarController() {
         self.viewControllers = createTabViewControllers()
     }
    
    
}

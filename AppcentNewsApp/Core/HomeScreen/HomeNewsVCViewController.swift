//
//  HomeNewsVCViewController.swift
//  AppcentNewsApp
//
//  Created by abdullah on 11.05.2024.
//

import UIKit

class HomeNewsVCViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
       
        NetworkManager.shared.getNews(newsKeyword: "bes", page: 1) { result in
            switch result {
            case .success(let success):
                print(success ?? "")
                break
            case .failure(let error):
                print(error)
                break
            }
        }
       
    }
    

   

}

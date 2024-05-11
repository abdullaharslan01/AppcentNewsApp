//
//  DetailScreenViewModel.swift
//  AppcentNewsApp
//
//  Created by abdullah on 11.05.2024.
//

import UIKit

protocol DetailScreenDelegate: AnyObject{
    func viewDidload()
    func configureViewDesign()
    func setUpView()
}


final class DetailScreen: UIViewController {

    var viewModel = DetailScreenViewModel()
    var article: Article?
    
    var imageView    = ANImageView(frame: .zero)
    var titleLabel   = ANTitleLabel(textAlignment: .left, fontsize: 20)
    var contentLabel = ANBodyLabel(textAligment: .left)
    let scroolView   = UIScrollView()
    let stackView    = UIStackView()
    let infos       = UIStackView()
 
    let item1       = ANItemInfoView(frame: .zero)
    let item2       = ANItemInfoView(frame: .zero)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        viewModel.viewDidLoad()
        print(article?._title ?? "")
        print(article?.description ?? "")
        print(article?.content ?? "")
        print(article?.publishedAt ?? "")

        
    }
    

}

extension DetailScreen: DetailScreenDelegate{
    func setUpView() {
        view.addSubview(scroolView)
        scroolView.addSubview(stackView)
        
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(infos)
        stackView.addArrangedSubview(item1)
        stackView.addArrangedSubview(contentLabel)
        infos.addArrangedSubview(item1)
        infos.addArrangedSubview(item2)
        
        scroolView.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints  = false
        
        let padding: CGFloat = 12
        
        NSLayoutConstraint.activate([
            scroolView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: padding),
            scroolView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            scroolView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            scroolView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            stackView.topAnchor.constraint(equalTo: scroolView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: scroolView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: scroolView.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: scroolView.bottomAnchor),
            stackView.widthAnchor.constraint(equalTo: scroolView.widthAnchor),
            imageView.heightAnchor.constraint(equalToConstant: .dHeight / 3),
            infos.heightAnchor.constraint(equalToConstant: 15),
            
        ])
    }

    func configureViewDesign() {
        
        infos.axis = .horizontal
        infos.distribution = .equalSpacing
        
   
        stackView.axis  = .vertical
        stackView.spacing = 20
        imageView.clipsToBounds = true
        
        guard let article = article else {return}
        item1.set(itemLogo: "person", itemText: article._author)
        item2.set(itemLogo: "calendar", itemText: article._publishedAt)

        contentLabel.text = article._content
        titleLabel.text   = article._title
        titleLabel.numberOfLines  = 0
        contentLabel.numberOfLines = 0
        contentLabel.font = UIFont.systemFont(ofSize: 16)
        imageView.downloadImage(from: article._urlToImage)
    }
    
    func viewDidload() {
        view.backgroundColor = .systemBackground
    
        navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        let shareButton = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
        let favoriteButton = UIBarButtonItem(image: UIImage(systemName: "heart"), style: .plain, target: self, action: #selector(favoriteTapped))
           
           navigationItem.rightBarButtonItems = [favoriteButton, shareButton]
        
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = true

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = false
    }
    
    

   @objc func shareTapped() {
       
   }

   @objc func favoriteTapped() {
       
   }
    
    
    
    
}

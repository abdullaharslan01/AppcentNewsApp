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
    func showAlertMessage(title:String, messsage:String)}


final class DetailScreen: UIViewController {

    var viewModel = DetailScreenViewModel()
    var article: Article?
    
    var imageView        = ANImageView(frame: .zero)
    var titleLabel       = ANTitleLabel(textAlignment: .left, fontsize: 20)
    var contentLabel     = ANBodyLabel(textAligment: .left)
    let scroolView       = UIScrollView()
    let stackView        = UIStackView()
    let infos            = UIStackView()
    let item1            = ANItemInfoView(frame: .zero)
    let item2            = ANItemInfoView(frame: .zero)
    
    let toolBar          =  UIView()
    var isFavorite:Bool  = false
    let newsSourceButton = ANButton(title: ANTexts.ANButtonTitle)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        viewModel.viewDidLoad()
    }
    

}

extension DetailScreen: DetailScreenDelegate{
    func showAlertMessage(title:String, messsage:String) {
        self.ANShowAlert(title: title, message: messsage)
    }
    
    func setUpView() {
        view.addSubview(scroolView)
        view.addSubview(toolBar)
      
        scroolView.addSubview(stackView)
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(infos)
        stackView.addArrangedSubview(item1)
        stackView.addArrangedSubview(contentLabel)
        infos.addArrangedSubview(item1)
        infos.addArrangedSubview(item2)
        toolBar.addSubview(newsSourceButton)
        newsSourceButton.translatesAutoresizingMaskIntoConstraints = false
        scroolView.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints  = false
        toolBar.translatesAutoresizingMaskIntoConstraints   = false
        
        let padding: CGFloat = 12
        
        NSLayoutConstraint.activate([
            toolBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            toolBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            toolBar.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -padding),
            toolBar.heightAnchor.constraint(equalToConstant: 75),
            
            newsSourceButton.centerYAnchor.constraint(equalTo: toolBar.centerYAnchor),
            newsSourceButton.heightAnchor.constraint(equalToConstant: 40),
            newsSourceButton.leadingAnchor.constraint(equalTo: toolBar.leadingAnchor, constant: 50),
            newsSourceButton.trailingAnchor.constraint(equalTo: toolBar.trailingAnchor, constant: -50),
            
            scroolView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: padding),
            scroolView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            scroolView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            scroolView.bottomAnchor.constraint(equalTo: toolBar.topAnchor),
            
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
        
        newsSourceButton.addTarget(self, action: #selector(detailWebPage), for: .touchUpInside)
   
        stackView.axis  = .vertical
        stackView.spacing = 20
        imageView.clipsToBounds = true
        
        guard let article = article else {return}
        item1.set(itemLogo: ANSymbols.person, itemText: article._author)
        item2.set(itemLogo: ANSymbols.calendar, itemText: article._publishedAt.contvertToDisplayFormat())

        contentLabel.text = article._content
        titleLabel.text   = article._title
        titleLabel.numberOfLines  = 0
        contentLabel.numberOfLines = 0
        contentLabel.font = UIFont.systemFont(ofSize: 16)
        imageView.downloadImage(from: article._urlToImage,animationState: true)
    }
    
    func viewDidload() {
        view.backgroundColor = .systemBackground
    
        let favoriteImage = UIImage(systemName: isFavorite ? ANSymbols.favoritesFill : ANSymbols.favorites)
        
        navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        let shareButton = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
        let favoriteButton = UIBarButtonItem(image: favoriteImage, style: .plain, target: self, action: #selector(favoriteTapped))
           
           navigationItem.rightBarButtonItems = [favoriteButton, shareButton]
        
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = true
        navigationController?.setToolbarHidden(true, animated: false)

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = false
        

    }
    

        
    @objc func detailWebPage() {
        
        guard let urlText = article?._url, let url = URL(string: urlText) else {return}
        
        
        ANPresentSafariVC(with: url)
    }

   @objc func shareTapped() {
       
       guard let article = article else { return
           
       }
       
       let message = "\(ANTexts.userShareTitle)\n\(article._title): \(article._content)\n \(article._url)"

       
       let activetyController = UIActivityViewController(activityItems: [message,], applicationActivities: nil)
       present(activetyController, animated: true)
       
   }

   @objc func favoriteTapped() {
    
       isFavorite.toggle()
       
       if isFavorite {
           navigationItem.rightBarButtonItems?[0].image = UIImage(systemName: ANSymbols.favoritesFill)
                
           guard let article = article else {return}
           viewModel.favoriteArticle(article: article)
           
          } else {
              navigationItem.rightBarButtonItems?[0].image = UIImage(systemName: ANSymbols.favorites)
              
             
              
          }
       
   }
    
    
    
    
}

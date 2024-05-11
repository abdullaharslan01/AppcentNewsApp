//
//  ANTableViewCell.swift
//  AppcentNewsApp
//
//  Created by abdullah on 11.05.2024.
//

import UIKit

class ANTableViewCell: UITableViewCell {

    static let reuseID:String      = "ANTableViewCell"
    let newsImage:ANImageView      = ANImageView(frame: .zero)
    let title: ANTitleLabel        = ANTitleLabel(textAlignment: .left, fontsize: ANSizes.labelTitleSize)
    let content: ANBodyLabel          = ANBodyLabel(textAligment: .justified)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(article: Article) {
        title.text  = article._title
        content.text   = article._content
        newsImage.downloadImage(from: article._urlToImage)
    }
    
    private func configure(){
        addSubview(title)
        addSubview(content)
        addSubview(newsImage)
        
        let padding: CGFloat = 12
        
        NSLayoutConstraint.activate([
        
            newsImage.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            newsImage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            newsImage.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -padding),
            newsImage.widthAnchor.constraint(equalToConstant: 100),
            newsImage.heightAnchor.constraint(equalToConstant: 60),
            
            title.leadingAnchor.constraint(equalTo: leadingAnchor,constant: padding),
            title.heightAnchor.constraint(equalToConstant: 30),
            title.trailingAnchor.constraint(equalTo: newsImage.leadingAnchor, constant: -padding),
            
            content.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            content.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -padding)


            
        ])
        
        
    }
    

}

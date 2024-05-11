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
    let title: ANTitleLabel        = ANTitleLabel(textAlignment: .left, fontsize: 25)
    let content: ANBodyLabel       = ANBodyLabel(textAligment: .left)
    
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
    
    override func prepareForReuse() {
        super.prepareForReuse()
        newsImage.cancelDownloading()
    }
    
    private func configure(){
        addSubview(title)
        addSubview(content)
        addSubview(newsImage)
        content.numberOfLines = 2
        
        let padding: CGFloat = 15
        
        NSLayoutConstraint.activate([
        
            newsImage.centerYAnchor.constraint(equalTo: centerYAnchor),
            newsImage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            newsImage.widthAnchor.constraint(equalToConstant: 120),
            newsImage.heightAnchor.constraint(equalToConstant: 80),
            
            title.topAnchor.constraint(equalTo: topAnchor,constant: padding),
            title.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            title.trailingAnchor.constraint(equalTo: newsImage.leadingAnchor, constant: -padding),
            
            content.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            content.topAnchor.constraint(equalTo: title.bottomAnchor, constant: padding),
            content.trailingAnchor.constraint(equalTo: newsImage.leadingAnchor, constant: -padding)

            
        ])
        
        
    }
    

}

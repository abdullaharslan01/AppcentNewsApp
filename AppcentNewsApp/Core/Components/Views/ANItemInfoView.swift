//
//  ANItemInfoView.swift
//  AppcentNewsApp
//
//  Created by abdullah on 11.05.2024.
//

import UIKit

class ANItemInfoView: UIView {
    
    let symbolImageView = UIImageView()
    let titleLabel      = ANTitleLabel(textAlignment: .left, fontsize: 14)
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(itemLogo: String, itemText:String) {
        symbolImageView.image = UIImage(systemName: itemLogo)
        titleLabel.text = itemText
    }
    
    
    
    private func configure(){
        addSubview(symbolImageView)
        addSubview(titleLabel)
        symbolImageView.contentMode = .scaleAspectFill
        symbolImageView.translatesAutoresizingMaskIntoConstraints = false
        symbolImageView.tintColor = ANColors.mainColor
        NSLayoutConstraint.activate([
            symbolImageView.topAnchor.constraint(equalTo: topAnchor),
            symbolImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            symbolImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            symbolImageView.widthAnchor.constraint(equalToConstant: 15),
            symbolImageView.heightAnchor.constraint(equalToConstant: 15),
            titleLabel.centerYAnchor.constraint(equalTo: symbolImageView.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: symbolImageView.trailingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 18)
        
        
        ])
        
        
    }

  

}

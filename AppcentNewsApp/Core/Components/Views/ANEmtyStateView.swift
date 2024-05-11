//
//  ANEmtyStateView.swift
//  AppcentNewsApp
//
//  Created by abdullah on 11.05.2024.
//

import UIKit

class ANEmtyStateView: UIView {

  
    let messageLabel  = ANTitleLabel(textAlignment: .center, fontsize: 18)
    
    let logoImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    init(message: String) {
           super.init(frame: .zero)
           messageLabel.text = message
           configure()
       }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure(){
            
            addSubview(messageLabel)
            addSubview(logoImageView)
            
            messageLabel.numberOfLines      = 3
            messageLabel.textColor          = .secondaryLabel            
        logoImageView.image             = UIImage(named: ANImages.emtyStateImage)
            logoImageView.translatesAutoresizingMaskIntoConstraints = false
        
        let padding: CGFloat = 20
    
        
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: padding * 2),
            logoImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            logoImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            logoImageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.3),
            
            messageLabel.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: padding),
            messageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            messageLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            messageLabel.heightAnchor.constraint(equalToConstant: 50)
        ])


        }
    
}

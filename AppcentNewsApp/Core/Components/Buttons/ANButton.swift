//
//  ANButton.swift
//  AppcentNewsApp
//
//  Created by abdullah on 11.05.2024.
//

import UIKit
class ANButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    init( title: String) {
        super.init(frame: .zero)
        self.setTitle(title, for: .normal)
        configure()

    }
    
   
    
    private func configure(){
        self.backgroundColor = .systemBackground
        layer.borderWidth           = 2
        layer.borderColor           = ANColors.mainColor.cgColor
        layer.cornerRadius          = 10
        setTitleColor(ANColors.mainColor, for: .normal)
        titleLabel?.font            = UIFont.preferredFont(forTextStyle: .headline)
    
        translatesAutoresizingMaskIntoConstraints = false
        
        
    }
    
   
    
}

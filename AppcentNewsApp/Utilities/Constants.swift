//
//  Constants.swift
//  AppcentNewsApp
//
//  Created by abdullah on 11.05.2024.
//

import UIKit


enum ANSymbols {
    static let home = "house.fill"
    static let favorites = "heart"
}

enum ANImages {
    static let placeHolder = "place-holder"
    static let emtyStateImage = "emty-state"
}

enum ANColors{
    // I am using original Appcent Logo Color
  static let mainColor =  UIColor(red: CGFloat(245) / 255.0, green: CGFloat(130) / 255.0, blue: CGFloat(32) / 255.0, alpha: 1.0)
    

    static let labelTitleColor = UIColor.label
    static let labelBodyColor  = UIColor.secondaryLabel
    
}



enum ANTexts{
    static let searchBarText = "Search for news..."
    static let emttyPageText = "Please search for the news you want!"
}

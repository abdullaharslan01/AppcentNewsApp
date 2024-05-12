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
    static let favoritesFill = "heart.fill"
    static let person = "person"
    static let calendar = "calendar"
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
    static let ANButtonTitle          = "News Source"
    static let removeButtonTitle      = "Remove"
    static let userShareTitle         = "Hey look this news:"
    static let somethingWrong         = "Something went wrong"
    static let error                  = "Error"
    static let warning                = "Warning"
    static let searchBarText          = "Search for news..."
    static let emtyPageText           = "Please search for the news you want!"
    static let emtyFavoritePageText   = "There is no news you have added to your favorites."
    static let homeScreenTitle        = "Appcent NewsApp"
    static let favoriteScreenTitle    = "Favorites"
    static let outOfNewsText          = "That's all! There are no more news available at the moment. You can make a more specific search or try again later."
}

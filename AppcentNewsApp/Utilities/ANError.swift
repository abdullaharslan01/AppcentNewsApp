//
//  ANError.swift
//  AppcentNewsApp
//
//  Created by abdullah on 11.05.2024.
//

import Foundation

enum ANError: String, Error{

    case invalidKeyword         = "This keyword is invalid. Please try again."
    case unableToComplete       = "Unable to complete your request. Please check your internet connection"
    case invalidResponse        = "Invalid response from the server. Please try again."
    case invalidData            = "The data received from the server was invalid. Please try again."
    
    case unableToFavorite       = "There was an error favoritting this user. Please try again."
    case alreadyInFavorites     = "You've already favorited this news. You must REALLY like it!"
    
}

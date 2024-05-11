//
//  DetailScreen.swift
//  AppcentNewsApp
//
//  Created by abdullah on 11.05.2024.
//

import UIKit

protocol DetailScreenViewModelDelegate{
    var delegate: DetailScreenDelegate? {get set}
    func viewDidLoad()
}


final class DetailScreenViewModel {
    weak var delegate: DetailScreenDelegate?
    
    
}


extension DetailScreenViewModel: DetailScreenViewModelDelegate{
   
    
    func viewDidLoad() {
        delegate?.viewDidload()
        delegate?.configureViewDesign()
        delegate?.setUpView()
    }
    
    
   
    
    
}

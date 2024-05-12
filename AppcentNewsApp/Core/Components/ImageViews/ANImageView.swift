//
//  ANImageView.swift
//  AppcentNewsApp
//
//  Created by abdullah on 11.05.2024.
//

import UIKit

class ANImageView: UIImageView {
    
    private var imageDownloadTask: URLSessionDataTask?

    let placeholderImage = UIImage(named: ANImages.emtyStateImage)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    private func configure(){
        layer.cornerRadius      = 5
        clipsToBounds           = true
        image                   = placeholderImage
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func animate1(to image: UIImage, duration: TimeInterval = 1.0) {
        let newImageView = UIImageView(image: image)
        newImageView.contentMode = self.contentMode
        newImageView.frame = self.frame.offsetBy(dx: self.frame.width, dy: 0)
        
        superview?.addSubview(newImageView)
        
        UIView.animate(withDuration: duration, animations: {
            newImageView.frame = self.frame
            self.alpha = 0
        }, completion: { _ in
            self.image = image
            self.alpha = 1
            newImageView.removeFromSuperview()
        })
    }

    func animate2(to image: UIImage, options: UIView.AnimationOptions = .transitionCrossDissolve) {
        UIView.transition(with: self, duration: 1.0, options: options, animations: {
            self.image = image
        }, completion: nil)
    }


    
    func downloadImage(from urlString: String, animationState:Bool = false) {
        guard let url = URL(string: urlString) else {return}
        
        imageDownloadTask = URLSession.shared.dataTask(with: url, completionHandler: {[weak self] data, response, error in
            guard let self = self else {return}
            
            if error != nil {return}
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {return}
            
            guard let data = data else {return}
            
            guard let image = UIImage(data: data) else {return}
            
            DispatchQueue.main.async {
                
            
                animationState ? self.animate1(to: image) : self.animate2(to: image)
                
                
            }
            
        }

        )
        imageDownloadTask?.resume()
        
        
        
    }
    
    func cancelDownloading(){
        imageDownloadTask?.cancel()
        imageDownloadTask = nil
    }
    
}

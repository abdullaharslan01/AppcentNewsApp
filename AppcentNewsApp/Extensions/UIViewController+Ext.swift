//
//  UIViewController+Ext.swift
//  AppcentNewsApp
//
//  Created by abdullah on 11.05.2024.
//

import UIKit

fileprivate var containerView: UIView!

extension UIViewController {

    
    func ANDismissEmptyStateView() {

        for subview in view.subviews {
            if let emptyStateView = subview as? ANEmtyStateView {
                emptyStateView.removeFromSuperview()
            }
        }
    }

    
    func ANShowEmptyStateView(with message: String, in view: UIView){
        
          let emtyStateView = ANEmtyStateView(message: message)
          emtyStateView.frame = view.bounds
          view.addSubview(emtyStateView)
      }
    
    
    func ANShowLoadingView(){
        containerView = UIView(frame: view.bounds)
        view.addSubview(containerView)
        containerView.backgroundColor = .systemBackground
        containerView?.alpha = 0
        UIView.animate(withDuration: 0.25) {
            containerView?.alpha = 0.8
        }
        
        let activityIndicator = UIActivityIndicatorView(style: .large)
        
        containerView.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        activityIndicator.startAnimating()
        
    }
    
    func ANDismissLoadingView(){
        DispatchQueue.main.async {
            containerView.removeFromSuperview()
            containerView = nil
        }
    }
}

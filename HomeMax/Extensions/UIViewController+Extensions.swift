//
//  UIViewController+Extensions.swift
//  HomeMax
//
//  Created by Ikmal Azman on 27/12/2021.
//

import UIKit

private var spinnerView : UIView?

extension UIViewController {
    /// Add UIActivityIndicatorView to current view controller
    func addSpinnerView(_ color : UIColor = .gray, _ style : UIActivityIndicatorView.Style = .medium) {
        spinnerView = UIView(frame: view.bounds)
        guard let spinnerView = spinnerView else {
            return
        }
        let activityIndicator = UIActivityIndicatorView(style: style)
        activityIndicator.center = spinnerView.center
        activityIndicator.color = color
        activityIndicator.startAnimating()
        
        spinnerView.addSubview(activityIndicator)
        view.addSubview(spinnerView)
    }
    /// Remove UIActivityIndicatorView to current view controller
    func removeSpinnerView() {
        spinnerView?.removeFromSuperview()
    }
    /// Show toaster message to current view
    func showToaster(withMessage message : String) {
        let toastLabel = UILabel()
        toastLabel.translatesAutoresizingMaskIntoConstraints = false
        toastLabel.backgroundColor = .primaryDarkGreen
        toastLabel.textColor = .white
        toastLabel.font = .systemFont(ofSize: 15)
        toastLabel.text = message
        toastLabel.textAlignment = .center
        toastLabel.layer.cornerRadius = 15
        toastLabel.clipsToBounds = true
        toastLabel.numberOfLines = 0
        
        self.view.addSubview(toastLabel)
        
        NSLayoutConstraint.activate([
            toastLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 20),
            toastLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            toastLabel.heightAnchor.constraint(equalToConstant: 100),
            toastLabel.widthAnchor.constraint(equalToConstant: 200)
        ])
        
        // Animate toaster
        UIView.animate(withDuration: 6.0, delay: 0.1, options: .curveEaseOut) {
            toastLabel.alpha = 0.0
        } completion: { isComplete in
            toastLabel.removeFromSuperview()
        }
    }
    
    /// Add Child view controller to Parent view controller
    func add(_ child : UIViewController) {
        addChild(child)
        view.addSubview(child.view)
        child.didMove(toParent: self)
    }
    /// Remove Child view controller to Parent view controller
    func remove(){
        // Make user the view controller is being added to parent
        guard parent != nil else {return}
        willMove(toParent: self)
        view.removeFromSuperview()
        removeFromParent()
    }
}

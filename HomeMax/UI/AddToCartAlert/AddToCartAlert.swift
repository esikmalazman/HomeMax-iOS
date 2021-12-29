//
//  AddToCartAlert.swift
//  HomeMax
//
//  Created by Ikmal Azman on 29/12/2021.
//

import UIKit

final class AddToCartAlert: UIViewController {
    //MARK: - Outlets
    @IBOutlet weak var alertLabel: UILabel!
    //MARK: - Variables
    static let nibName = "AddToCartAlert"
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        view.layer.cornerRadius = 20
    }
    
    func runAlertAnimation(completion : @escaping ((Bool)->Void)) {
        UIView.animate(withDuration: 2.0, delay: 0.1, options: .curveEaseInOut) {
            self.view.alpha = 0
        } completion: { isComplete in
            completion(isComplete)
        }
    }
    
    func setAlertContent(_ text : String) {
        alertLabel.text = text
    }
    
}

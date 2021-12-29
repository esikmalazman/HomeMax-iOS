//
//  BottomSheet.swift
//  HomeMax
//
//  Created by Ikmal Azman on 29/12/2021.
//

import UIKit

final class BottomSheet: UIViewController {
    //MARK: - Outlets
    @IBOutlet weak var productSheetImageView: UIImageView!
    @IBOutlet weak var productSheetLabel: UILabel!
    @IBOutlet weak var productSheetPrice: UILabel!
    
    //MARK: - Variables
    static let nibName = "BottomSheet"
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        view.layer.cornerRadius = 15
        productSheetImageView.layer.cornerRadius = 15
    }
    
    func runBottomSheetAnimation() {
        view.alpha = 0
        UIView.animate(withDuration: 1.0, delay: 0.1, options: .transitionFlipFromBottom ) {
            self.view.alpha = 1
        } completion: { _ in}
    }
    
    func setBottomSheetContent(image : String, label : String, price : Int) {
        productSheetImageView.image = UIImage(named: image)
        productSheetLabel.text = label
        productSheetPrice.text = "RM \(price)"
    }
    
}

//
//  ProductDetailsPresenter.swift
//  HomeMax
//
//  Created by Ikmal Azman on 29/12/2021.
//

import Foundation

protocol ProductDetailsPresenterDelegate : AnyObject {
    func presentActionAddToCart(_ ProductDetailsPresenter : ProductDetailsPresenter)
    func presentActionAR(_ ProductDetailsPresenter : ProductDetailsPresenter)
}

final class ProductDetailsPresenter {
    
    weak private var delegate : ProductDetailsPresenterDelegate?
    
    func setViewDelegate(delegate : ProductDetailsPresenterDelegate) {
        self.delegate = delegate
    }
    
    func didAddToCartTap() {
        delegate?.presentActionAddToCart(self)
    }
    
    func didARTap() {
        delegate?.presentActionAR(self)
    }
    
    func getARProduct(_ productName : String)-> Assets {
        switch productName {
        case "Sofa" :
            return Assets.sofa
        case "Bastone" :
            return Assets.bastone
        case "Bookcase" :
            return Assets.bookcase
        case "Dresser" :
            return Assets.dresser
        default :
            return Assets.bastone
        }
    }
}

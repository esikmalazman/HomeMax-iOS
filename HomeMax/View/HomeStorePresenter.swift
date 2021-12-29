//
//  HomeStorePresenter.swift
//  HomeMax
//
//  Created by Ikmal Azman on 29/12/2021.
//

import Foundation

protocol HomeStorePresenterDelegate : AnyObject {
    func presentActionDidSelectCell(_ HomeStorePresenter : HomeStorePresenter , index : Int)
    func presentProductDataSource(_ HomeStorePresenter : HomeStorePresenter , data : [Product])
}

final class HomeStorePresenter {
    
    weak private var delegate : HomeStorePresenterDelegate?
    private let productDataSource = ProductDataSource()
    
    func setViewDelegate(delegate : HomeStorePresenterDelegate) {
        self.delegate = delegate
    }
    
    func didTapProductList(atIndex index : Int) {
        delegate?.presentActionDidSelectCell(self, index: index)
    }
    
    func getProductList() {
        delegate?.presentProductDataSource(self, data: productDataSource.data)
    }
}

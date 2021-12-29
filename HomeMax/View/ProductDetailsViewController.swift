//
//  HomeStoreViewController.swift
//  HomeMax
//
//  Created by Ikmal Azman on 23/12/2021.
//

import UIKit

final class ProductDetailsViewController: UIViewController {
    //MARK: - Outlets
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productLabel: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var productDescription: UILabel!
    @IBOutlet weak var arBtn: UIButton!
    @IBOutlet weak var addToCartBtn: UIButton!
    
    //MARK: - Variables
    lazy var addToCartAlertView : AddToCartAlert = {
        let vc = AddToCartAlert(nibName: AddToCartAlert.nibName, bundle: nil)
        vc.view.translatesAutoresizingMaskIntoConstraints = false
        return vc
    }()
    
    var selectedProduct : Product?
    private let presenter = ProductDetailsPresenter()
    
    //MARK: - LifeCycle
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.tintColor = .primaryDarkGreen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.setViewDelegate(delegate: self)
        setupViewOutlets()
    }
    
    //MARK: - Actions
    @IBAction func addToCartTap(_ sender: UIButton) {
        presenter.didAddToCartTap()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? ARProductViewController {
            destination.assetsName = presenter.getARProduct(selectedProduct?.name ?? "Nil")
            destination.selectedProduct = selectedProduct
        }
    }
}

//MARK: - Presenter Delegate
extension ProductDetailsViewController : ProductDetailsPresenterDelegate {
    func presentActionAddToCart(_ ProductDetailsPresenter: ProductDetailsPresenter) {
        setupAlertView()
    }
}
//MARK: - Private Methods
extension ProductDetailsViewController {
    private func setupViewOutlets() {
        guard let product = selectedProduct else {
            return
        }
        productImageView.image = UIImage(named: product.image)
        productLabel.text = product.name
        productDescription.text = product.description
        productPrice.text = "RM \(product.price)"
        
        arBtn.layer.cornerRadius = 35
        addToCartBtn.layer.cornerRadius = 15
    }
    
    private func setupAlertView() {
        add(addToCartAlertView)
        setupAlertLayout()
        addToCartAlertView.runAlertAnimation { isComplete in
            self.navigationController?.popViewController(animated: true)
        }
        addToCartAlertView.setAlertContent("\(selectedProduct?.name ?? "Nil") has been added to the cart")
        view.isUserInteractionEnabled = false
    }
    private func setupAlertLayout() {
        NSLayoutConstraint.activate([
            addToCartAlertView.view.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height/3),
            addToCartAlertView.view.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor,constant: -50),
            addToCartAlertView.view.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 50),
            addToCartAlertView.view.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            addToCartAlertView.view.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}


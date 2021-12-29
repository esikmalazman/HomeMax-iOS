//
//  HomeStoreViewController.swift
//  HomeMax
//
//  Created by Ikmal Azman on 25/12/2021.
//

import UIKit

final class HomeStoreViewController: UIViewController {
    //MARK: - Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    
    //MARK: - Variables
    private var product = [Product]()
    private var selectedIndex : Int?
    private let presenter = HomeStorePresenter()
    
    //MARK: - LifeCycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let navigationController = navigationController else {return}
        AppTheme.clearDefaultNavigationBar(navigationController.navigationBar)
        navigationController.view.backgroundColor = .clear
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.setViewDelegate(delegate: self)
        presenter.getProductList()
        setupCollectionView()
    }
    
    private func setupCollectionView() {
        collectionView.register(ProductCollectionCell.nib(), forCellWithReuseIdentifier: "cell")
        collectionView.dataSource = self
        collectionView.delegate = self

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if  let destination = segue.destination as? ProductDetailsViewController {
            destination.selectedProduct = product[selectedIndex ?? 0]
        }
    }
}

//MARK: -  Datasource
extension HomeStoreViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return product.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ProductCollectionCell
        let item = product[indexPath.row]
        cell.setProductCellContent(image: item.image, label: item.name)
        return cell
    }
}

//MARK: - Delegate
extension HomeStoreViewController : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.didTapProductList(atIndex: indexPath.row)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let phoneWidth = UIScreen.main.bounds.width
        return CGSize(width: phoneWidth, height: 220)
    }
}
//MARK: - UICollectionViewDelegateFlowLayout
extension HomeStoreViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
}

//MARK: - Presenter Delegate
extension HomeStoreViewController: HomeStorePresenterDelegate {
    func presentProductDataSource(_ HomeStorePresenter: HomeStorePresenter, data: [Product]) {
        product = data
        collectionView.reloadData()
    }
    
    func presentActionDidSelectCell(_ HomeStorePresenter: HomeStorePresenter, index: Int) {
        selectedIndex = index
        performSegue(withIdentifier: SeguesID.toProductDetails, sender: self)
        print("Selected Item : \(index)")
    }
}

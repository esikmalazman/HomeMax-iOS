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
    private var furnitureItems = [Product]()
    let data = ProductDataSource()
    private var selectedIndex : Int?
    
    //MARK: - LifeCycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let navigationController = navigationController else {return}
        AppTheme.clearDefaultNavigationBar(navigationController.navigationBar)
        navigationController.view.backgroundColor = .clear
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        furnitureItems = data.data
        setupCollectionView()
    }
    
    private func setupCollectionView() {
        collectionView.register(ProductCollectionCell.nib(), forCellWithReuseIdentifier: "cell")
        collectionView.dataSource = self
        collectionView.delegate = self

    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if  let destination = segue.destination as? ProductDetailsViewController {
            destination.selectedProduct = furnitureItems[selectedIndex ?? 0]
        }
    }
}

//MARK: -  Datasource
extension HomeStoreViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return furnitureItems.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ProductCollectionCell
        let item = furnitureItems[indexPath.row]
        cell.setProductCellContent(image: item.image, label: item.name)
        return cell
    }
}

//MARK: - Delegate
extension HomeStoreViewController : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
        performSegue(withIdentifier: SeguesID.toProductDetails, sender: self)
        print("Item : \(indexPath.row)")
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let phoneWidth = UIScreen.main.bounds.width
        return CGSize(width: phoneWidth, height: 220)
    }
}

extension HomeStoreViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
}

//
//  ProductCollectionCell.swift
//  HomeMax
//
//  Created by Ikmal Azman on 25/12/2021.
//

import UIKit

final class ProductCollectionCell: UICollectionViewCell {
    //MARK: - Outlets
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productLabel: UILabel!
    
    //MARK: - Variables
    static let nibName = "ProductCollectionCell"
    //MARK: - LifeCycle
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.backgroundColor = .systemPink
        let padding = UIEdgeInsets(top: 10, left: 20, bottom: 5, right: 20)
        contentView.frame = contentView.frame.inset(by: padding)
        contentView.layer.cornerRadius = 15
        
        contentView.layer.borderColor = UIColor.black.cgColor
        contentView.layer.borderWidth = 0.08
        

        layer.backgroundColor = UIColor.clear.cgColor
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 3.0)
        layer.shadowOpacity = 0.05
        layer.shadowRadius = 0.2
    }
    
    static func nib() -> UINib {
        return UINib(nibName: nibName, bundle: nil)
    }
    
    func setProductCellContent(image : String, label : String) {
        productImage.image = UIImage(named: image)
        productLabel.text = label
    }
}

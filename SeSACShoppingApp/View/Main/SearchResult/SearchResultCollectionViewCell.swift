//
//  SearchResultCollectionViewCell.swift
//  SeSACShoppingApp
//
//  Created by Madeline on 1/19/24.
//

import Kingfisher
import UIKit

class SearchResultCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var itemCompanyLabel: UILabel!
    @IBOutlet weak var itemPriceLabel: UILabel!
    @IBOutlet weak var itemTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        itemCompanyLabel.textColor = .white
        itemPriceLabel.textColor = .white
        
    }
    
    func configureCell(with item: Item) {
        itemTitleLabel.text = item.title
        itemPriceLabel.text = item.lprice
        itemCompanyLabel.text = item.mallName
        
        if let url = URL(string: item.image) {
            itemImage.kf.setImage(with: url)
        }
    }
    
}

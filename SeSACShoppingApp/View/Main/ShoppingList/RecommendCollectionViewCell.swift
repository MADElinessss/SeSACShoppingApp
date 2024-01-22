//
//  RecommendCollectionViewCell.swift
//  SeSACShoppingApp
//
//  Created by Madeline on 1/22/24.
//

import Kingfisher
import UIKit

class RecommendCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var itemTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureCell(with item: Item) {
        itemTitleLabel.text = item.title
        priceLabel.text = item.lprice
        itemImageView.kf.setImage(with: URL(string: item.image))
        itemImageView.clipsToBounds = true
        itemImageView.contentMode = .scaleAspectFill
    }
}

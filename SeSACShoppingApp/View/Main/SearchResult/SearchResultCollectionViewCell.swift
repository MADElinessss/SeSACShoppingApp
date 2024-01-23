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
    
    var likeButtonTapped: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction func likeButtonAction(_ sender: UIButton) {
        likeButtonTapped?()
    }
    
    func configureCell(with item: Item) {
        itemCompanyLabel.textColor = .white
        itemPriceLabel.textColor = .white
        itemTitleLabel.numberOfLines = 2
        
        likeButton.layer.cornerRadius = 15
        
        let modifiedTitle = item.title.replacingOccurrences(of: "<b>", with: "").replacingOccurrences(of: "</b>", with: "")
        itemTitleLabel.text = modifiedTitle

        if let priceNumber = Int(item.lprice) {
            let formatter = NumberFormatter()
            formatter.numberStyle = .decimal
            let formattedPrice = formatter.string(from: NSNumber(value: priceNumber)) ?? item.lprice
            itemPriceLabel.text = formattedPrice
        } else {
            itemPriceLabel.text = item.lprice
        }
        itemCompanyLabel.text = item.mallName
        
        if let url = URL(string: item.image) {
            itemImage.kf.setImage(with: url)
        }
        itemImage.layer.cornerRadius = 10
    }
}

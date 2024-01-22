//
//  LikedItemsTableViewCell.swift
//  SeSACShoppingApp
//
//  Created by Madeline on 1/22/24.
//

import Kingfisher
import UIKit

class LikedItemsTableViewCell: UITableViewCell {
    
    static let identifier: String = "LikedItemsTableViewCell"
    
    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var companyLabel: UILabel!
    @IBOutlet weak var itemTitleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func configureCell(with item: Item) {
        itemTitleLabel.text = item.title
        companyLabel.text = item.mallName
        priceLabel.text = item.lprice
        itemImageView.kf.setImage(with: URL(string: item.image))
    }
    
}

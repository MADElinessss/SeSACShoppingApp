//
//  SettingsProfileTableViewCell.swift
//  SeSACShoppingApp
//
//  Created by Madeline on 1/20/24.
//

import UIKit

class SettingsProfileTableViewCell: UITableViewCell {

    static let identifier = "SettingsProfileTableViewCell"
    
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var itemCountLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
}

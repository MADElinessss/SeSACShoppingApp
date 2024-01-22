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
        
        userNameLabel.text = UserDefaults.standard.string(forKey: "userName") ?? "고객님"
        
//        let paddingView = UIView(frame: CGRect(x: 10, y: 0, width: contentView.frame.width - 20, height: contentView.frame.height))
//        paddingView.backgroundColor = .clear
//        contentView.addSubview(paddingView)
        
    }
}

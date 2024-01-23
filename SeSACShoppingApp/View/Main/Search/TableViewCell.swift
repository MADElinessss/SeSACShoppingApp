//
//  TableViewCell.swift
//  SeSACShoppingApp
//
//  Created by Madeline on 2024/01/18.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var historyLabel: UILabel!
    @IBOutlet weak var deleteButton: UIButton!
    
    static let identifier: String = "TableViewCell"
    var deleteButtonTappedHandler: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    @IBAction func deleteButtonTapped(_ sender: UIButton) {
        deleteButtonTappedHandler?()
    }
}

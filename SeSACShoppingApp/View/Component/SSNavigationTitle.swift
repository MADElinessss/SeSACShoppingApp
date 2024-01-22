//
//  SSNavigationTitle.swift
//  SeSACShoppingApp
//
//  Created by Madeline on 1/22/24.
//

import UIKit

extension UILabel {
    
    static func customNavigationTitle(_ title: String) -> UILabel {
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.textColor = .white
        titleLabel.font = .boldSystemFont(ofSize: 18)
        return titleLabel
    }
}

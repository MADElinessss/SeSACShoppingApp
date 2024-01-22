//
//  SSButton.swift
//  SeSACShoppingApp
//
//  Created by Madeline on 1/22/24.
//

import UIKit

extension UIButton {
    func customButton(_ title: String) {
        self.setTitle(title, for: .normal)
        self.tintColor = .white
        self.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
        self.backgroundColor = UIColor(named: "point")
        self.layer.cornerRadius = 10
    }
}

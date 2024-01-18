//
//  UIViewController+Extension.swift
//  SeSACShoppingApp
//
//  Created by Madeline on 2024/01/18.
//

import UIKit

extension UIViewController {
    static var identifier: String {
        return String(describing: self)
    }
    
    func setBackGroundColor() {
        view?.backgroundColor = .black
    }
}


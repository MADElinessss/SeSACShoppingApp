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

class SSButton: UIButton {
    
    var text: String? = nil {
        didSet {
            setTitle(text, for: .normal)
        }
    }
    
    // 코드 작업에 대한 초기화
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    func configureView() {
        
        backgroundColor = UIColor(named: "point")
        layer.cornerRadius = 10
        
    }
    
    // 스토리보드에 대한 초기화
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
}

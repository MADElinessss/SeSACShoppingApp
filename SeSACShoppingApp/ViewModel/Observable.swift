//
//  Observable.swift
//  SeSACShoppingApp
//
//  Created by Madeline on 2/22/24.
//

import Foundation

class Observable {
    
    private var closure: ((String) -> Void)?
    
    var text: String {
        didSet {
            closure?(text)
        }
    }
    
    init(_ text: String) {
        self.text = text
    }
    
    func bind(_ closure: @escaping (String) -> Void) {
        print("bind")
        closure(text)
        self.closure = closure
    }
}

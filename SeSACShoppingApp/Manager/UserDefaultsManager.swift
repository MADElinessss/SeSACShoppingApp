//
//  UserDefaultsManager.swift
//  SeSACShoppingApp
//
//  Created by Madeline on 2024/01/18.
//

import Foundation

class UserDefaultsManager {
    
    private init() { }
    
    static let shared = UserDefaultsManager()
    
    enum UserDefaultsKey: String {
        case searchHistory
    }
    
    let ud = UserDefaults.standard
    
    var searchHistory: [String] {
        get {
            ud.array(forKey: "searchHistory") as? [String] ?? []
        }
        set {
            ud.set(newValue, forKey: "searchHistory")
        }
    }
}




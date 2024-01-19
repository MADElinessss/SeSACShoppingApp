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
        case source
        case target
    }
    
    let ud = UserDefaults.standard
    
    var source: String {
        get {
            ud.string(forKey: UserDefaultsKey.source.rawValue) ?? "ko"
            // 사용: UserDefaultsManager().source
        }
        set {
            ud.set(newValue, forKey: UserDefaultsKey.source.rawValue)
            // 사용: UserDefaultsManager().source = userSelect <- newValue
        }
    }
    
    var target: String {
        get {
            ud.string(forKey: UserDefaultsKey.target.rawValue) ?? "ko"
        }
        set {
            ud.set(newValue, forKey: UserDefaultsKey.target.rawValue)
        }
    }
}




//
//  UserDefaultsManager.swift
//  SeSACShoppingApp
//
//  Created by Madeline on 2024/01/18.
//

import Foundation

enum UserDefaultsKey: String {
    case searchHistory
    case likedProducts
    case UserState
    case selectedImage
    case userName
}

class UserDefaultsManager {
    
    private init() { }
    
    static let shared = UserDefaultsManager()
    
    let ud = UserDefaults.standard
    
    var searchHistory: [String] {
        get {
            ud.array(forKey: UserDefaultsKey.searchHistory.rawValue) as? [String] ?? []
        }
        set {
            ud.set(newValue, forKey: UserDefaultsKey.searchHistory.rawValue)
        }
    }
    
    var likedProducts: [String: Bool] {
        get {
            return ud.dictionary(forKey: UserDefaultsKey.likedProducts.rawValue) as? [String: Bool] ?? [:]
        }
        set {
            ud.set(newValue, forKey: UserDefaultsKey.likedProducts.rawValue)
        }
    }
    
    var userState: Bool {
        get {
            ud.bool(forKey: UserDefaultsKey.UserState.rawValue)
        }
        set {
            ud.set(newValue, forKey: UserDefaultsKey.UserState.rawValue)
        }
    }
    
    var selectedImage: String {
        get {
            ud.string(forKey: UserDefaultsKey.selectedImage.rawValue) ?? "profile1"
        }
        set {
            ud.set(newValue, forKey: UserDefaultsKey.selectedImage.rawValue)
        }
    }
    
    var userName: String {
        get {
            ud.string(forKey: UserDefaultsKey.userName.rawValue) ?? "고객님"
        }
        set {
            ud.set(newValue, forKey: UserDefaultsKey.userName.rawValue)
        }
    }
}




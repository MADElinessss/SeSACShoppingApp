//
//  ShoppingAPI.swift
//  SeSACShoppingApp
//
//  Created by Madeline on 2/5/24.
//

import Foundation

enum ShoppingAPI {
    case accuracy
    case date
    case highPrice
    case lowPrice
    
    var baseURL: String {
        return "https://openapi.naver.com/v1/search/shop.json"
    }
    
    var endPoint: URL {
        switch self {
        case .accuracy:
            return URL(string: baseURL + "&sort=sim")!
        case .date:
            return URL(string: baseURL + "&sort=date")!
        case .highPrice:
            return URL(string: baseURL + "&sort=asc")!
        case .lowPrice:
            return URL(string: baseURL + "&sort=dsc")!
        }
    }
}

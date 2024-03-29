//
//  HTTPResponse.swift
//  SeSACShoppingApp
//
//  Created by Madeline on 1/19/24.
//

import Foundation

// MARK: - Search
struct Search: Decodable {
    let lastBuildDate: String?
    let total, start, display: Int?
    let items: [Item]?
}

// MARK: - Item
struct Item: Decodable {
    let title: String
    let link: String
    let image: String
    let lprice, hprice, mallName, productID: String
    let productType, brand: String
    let maker: String?
    let category1: String
    let category2: String
    let category3: String
    let category4: String

    enum CodingKeys: String, CodingKey {
        case title, link, image, lprice, hprice, mallName
        case productID = "productId"
        case productType, brand, maker, category1, category2, category3, category4
    }
}

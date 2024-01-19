//
//  APIManager.swift
//  SeSACShoppingApp
//
//  Created by Madeline on 1/19/24.
//

import Alamofire
import Foundation

struct APIManager {
    func callRequest(_ keyword: String, _ sort: String, completionHandler: @escaping ([Item]) -> Void) {
        let encodedKeyword = keyword.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let url = "https://openapi.naver.com/v1/search/shop.json?query=\(encodedKeyword)&display=10&start=1&sort=\(sort)"

        AF.request(url, method: .get).responseDecodable(of: Search.self) { response in
            switch response.result {
            case .success(let success):
                print(success)
                // completionHandler(success.items)
            case .failure(let failure):
                print(failure)
            }
        }
    }
}

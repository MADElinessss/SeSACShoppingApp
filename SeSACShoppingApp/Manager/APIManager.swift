//
//  APIManager.swift
//  SeSACShoppingApp
//
//  Created by Madeline on 1/19/24.
//

import Alamofire
import Foundation

struct APIManager {
    func callRequest(_ keyword: String, _ sort: String, completionHandler: @escaping (Search) -> Void) {
        let encodedKeyword = keyword.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let url = "https://openapi.naver.com/v1/search/shop.json?query=\(encodedKeyword)&display=10&start=1&sort=\(sort)"
        
        let headers: HTTPHeaders = [
            "X-Naver-Client-Id": APIKey.naverClientID,
            "X-Naver-Client-Secret": APIKey.naverClientSecret
        ]
        AF.request(url, method: .get, headers: headers).responseDecodable(of: Search.self) { response in
            switch response.result {
            case .success(let success):
                print(success)
                completionHandler(success)
            case .failure(let failure):
                completionHandler(Search(lastBuildDate: nil, total: nil, start: nil, display: nil, items: nil))
            }
        }
    }
}

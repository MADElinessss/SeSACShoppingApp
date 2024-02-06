//
//  APISessionManager.swift
//  SeSACShoppingApp
//
//  Created by Madeline on 2/5/24.
//

import Foundation

enum ErrorType: Error {
    case failedRequest
    case emptyData
    case wrongData
    case invalidResponse
    case invalidData
}

class APISessionManager {
    
    static let shared = APISessionManager()
    
    private init() { }
    
    func callRequest<T: Decodable>(keyword: String, sort: String, page: Int, url: URL, completionHandler: @escaping ((T?, ErrorType?) -> Void)) {
        
        let encodedKeyword = keyword.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        
        let url = URL(string: "https://openapi.naver.com/v1/search/shop.json?query=\(encodedKeyword)&display=30&start=\(page)&sort=\(sort)")
        
        var request: URLRequest = URLRequest(url: url!)
        
        request.addValue(APIKey.naverClientID, forHTTPHeaderField: "X-Naver-Client-Id")
        request.addValue(APIKey.naverClientSecret, forHTTPHeaderField: "X-Naver-Client-Secret")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async() {
                guard error == nil else {
                    completionHandler(nil, .failedRequest)
                    return
                }
                guard let data = data else {
                    completionHandler(nil, .emptyData)
                    return
                }
                
                guard let response = response as? HTTPURLResponse else {
                    completionHandler(nil, .invalidResponse)
                    return
                }
                
                guard response.statusCode == 200 else {
                    completionHandler(nil, .invalidResponse)
                    return
                }
                
                do {
                    let result = try JSONDecoder().decode(T.self, from: data)
                    completionHandler(result, nil)
                } catch {
                    completionHandler(nil, .wrongData)
                }
            }
        }
    }
    
}

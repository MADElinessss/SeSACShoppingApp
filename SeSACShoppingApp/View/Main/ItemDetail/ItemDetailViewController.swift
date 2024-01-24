//
//  ItemDetailViewController.swift
//  SeSACShoppingApp
//
//  Created by Madeline on 1/20/24.
//

import UIKit
import WebKit

class ItemDetailViewController: UIViewController {

    @IBOutlet weak var webView: WKWebView!
    
    var productId: String = "1"
    var selectedItem: String = "선택한 물품"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setBackGroundColor()
        configureView()
        
        let url = URL(string: "https://msearch.shopping.naver.com/product/\(productId)")
        
        if let url {
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }
    
    func configureView() {
        let isLiked = UserDefaultsManager.shared.likedProducts[productId] ?? false
        let button = UIBarButtonItem(image: UIImage(systemName: isLiked ? "heart.fill" : "heart"), style: .plain, target: self, action: #selector(heartButtonTapped))
        
        navigationItem.titleView = UILabel.customNavigationTitle(selectedItem)
        navigationItem.rightBarButtonItem = button
        
    }
    
    @objc func heartButtonTapped() {
        var likedProducts = UserDefaultsManager.shared.likedProducts
        let isLiked = !(likedProducts[productId] ?? false)
        likedProducts[productId] = isLiked
        UserDefaultsManager.shared.likedProducts = likedProducts
        configureView()
    }
}

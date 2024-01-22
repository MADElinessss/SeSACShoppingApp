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
        let isLiked = UserDefaults.standard.bool(forKey: productId)
        let button = UIBarButtonItem(image: UIImage(systemName: isLiked ? "heart.fill" : "heart"), style: .plain, target: self, action: #selector(heartButtonTapped))
        
        navigationItem.titleView = UILabel.customNavigationTitle(selectedItem)
        navigationItem.rightBarButtonItem = button
        
    }
    
    // MARK: 🆘 SOS - 상세 페이지에 있는 좋아요 버튼 로직..뭔가 엄청 비효율적인 것 같아요..😭
    @objc func heartButtonTapped() {
        var isLiked = UserDefaults.standard.bool(forKey: productId)
        isLiked.toggle()
        let button = UIBarButtonItem(image: UIImage(systemName: isLiked ? "heart.fill" : "heart"), style: .plain, target: self, action: #selector(heartButtonTapped))
        navigationItem.rightBarButtonItem = button
        UserDefaults.standard.setValue(isLiked, forKey: productId)
    }
}

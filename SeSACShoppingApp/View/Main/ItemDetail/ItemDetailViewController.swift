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
        
        navigationItem.titleView = UILabel.customNavigationTitle(selectedItem)
        
        let url = URL(string: "https://msearch.shopping.naver.com/product/\(productId)")
        
        if let url {
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }
}

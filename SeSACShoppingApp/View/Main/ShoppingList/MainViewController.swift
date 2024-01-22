//
//  MainViewController.swift
//  SeSACShoppingApp
//
//  Created by Madeline on 2024/01/18.
//

import UIKit

// 나의 욕심(이었던 것..)
class MainViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var likedItems: [Item] = []
    var featuredProducts: [Item] = []
    let searchKeywords = ["니트", "생활용품", "키링", "바인더", "셔츠", "과메기", "토트백"]
    var selectedKeyword = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setBackGroundColor()
        configureView()
        loadLikedProducts()
        performRandomSearch()
    }
    
    func configureView() {
        let nib1 = UINib(nibName: "RecommendCollectionViewCell", bundle: nil)
        collectionView.register(nib1, forCellWithReuseIdentifier: "FeaturedProductCell")
        
        let nib2 = UINib(nibName: "LikedItemsTableViewCell", bundle: nil)
        tableView.register(nib2, forCellReuseIdentifier: "LikedItemsTableViewCell")
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .black
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .black
        
    }
    
    func loadLikedProducts() {
        let likedProductIDs = UserDefaults.standard.array(forKey: "likedProductIDs") as? [String] ?? []

        likedProductIDs.forEach { productId in
            APIManager().callRequest(productId, "sim", page: 1) { [weak self] searchResult in
                guard let self = self else { return }
                if let items = searchResult.items, !items.isEmpty {
                    self.likedItems.append(contentsOf: items)
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
            }
        }
    }

    func performRandomSearch() {
        selectedKeyword = searchKeywords.randomElement() ?? ""
        APIManager().callRequest(selectedKeyword, "sim", page: 1) { [weak self] searchResult in
            guard let self = self else { return }
            self.featuredProducts = Array(searchResult.items?.prefix(3) ?? [])
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return likedItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: LikedItemsTableViewCell.identifier, for: indexPath) as? LikedItemsTableViewCell else {
            return UITableViewCell()
        }
        
        cell.configureCell(with: likedItems[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "찜한 상품"
    }
}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return min(featuredProducts.count, 6)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FeaturedProductCell", for: indexPath) as? RecommendCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.configureCell(with: featuredProducts[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // 셀의 너비와 높이를 설정
        let cellWidth = collectionView.frame.width / 2 - 10 // 가로 길이를 계산
        let cellHeight = cellWidth * 1.5 // 세로 길이를 비율로 설정
        
        return CGSize(width: cellWidth, height: cellHeight)
    }
}

//
//  SearchResultViewController.swift
//  SeSACShoppingApp
//
//  Created by Madeline on 1/19/24.
//

import UIKit

class SearchResultViewController: UIViewController {

    @IBOutlet weak var totalCountLabel: UILabel!
    @IBOutlet weak var itemCollectionView: UICollectionView!
    
    let sectionInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    let manager = APIManager()
    
    var items: [Item] = []
    
    var searchResult: Search?
    
    var searchKeyword: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setBackGroundColor()
        configureView()
        fetchItems(sort: "sim")
        
    }
    
    // MARK: 상품 정렬 버튼 클릭 액션
    @IBAction func accuracySortButton(_ sender: UIButton) {
        fetchItems(sort: "sim")
    }

    @IBAction func recentSortButton(_ sender: UIButton) {
        fetchItems(sort: "date")
    }

    @IBAction func priceAscendingButton(_ sender: UIButton) {
        fetchItems(sort: "asc")
    }

    @IBAction func priceDescendingButton(_ sender: UIButton) {
        fetchItems(sort: "dsc")
    }

    // MARK: API 호출 및 데이터 가져오기
    private func fetchItems(sort: String) {
        manager.callRequest(searchKeyword, sort) { [weak self] searchResult in
            guard let self = self else { return }
            self.searchResult = searchResult
            self.items = searchResult.items ?? []
            self.totalCountLabel.text = "\(self.searchResult?.total ?? 0)개의 검색 결과"
            self.itemCollectionView.reloadData()
        }
    }
    
    func configureView() {
        itemCollectionView.delegate = self
        itemCollectionView.dataSource = self
        
        let xib = UINib(nibName: "SearchResultCollectionViewCell", bundle: nil)
        itemCollectionView.register(xib, forCellWithReuseIdentifier: "SearchResultCollectionViewCell")
    }
    
}

extension SearchResultViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = itemCollectionView.dequeueReusableCell(withReuseIdentifier: "SearchResultCollectionViewCell", for: indexPath) as? SearchResultCollectionViewCell else {
            fatalError("Unable to dequeue SearchResultCollectionViewCell")
        }

        let item = items[indexPath.row]
        cell.configureCell(with: item)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSize(width: 100, height: 200)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // TODO: 셀 선택시 웹뷰로 연결
    }
}

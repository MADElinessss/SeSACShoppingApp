//
//  SearchResultViewController.swift
//  SeSACShoppingApp
//
//  Created by Madeline on 1/19/24.
//

import UIKit

class SearchResultViewController: UIViewController {

    @IBOutlet weak var totalCountLabel: UILabel!
    
    @IBOutlet weak var simSortButton: UIButton!
    @IBOutlet weak var dateSortButton: UIButton!
    @IBOutlet weak var priceDescendingButton: UIButton!
    @IBOutlet weak var priceAscendingButton: UIButton!
    
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
        updateButtonStyles(selectedButton: sender)
    }

    @IBAction func recentSortButton(_ sender: UIButton) {
        fetchItems(sort: "date")
        updateButtonStyles(selectedButton: sender)
    }

    @IBAction func priceAscendingButton(_ sender: UIButton) {
        fetchItems(sort: "dsc")
        updateButtonStyles(selectedButton: sender)
    }

    @IBAction func priceDescendingButton(_ sender: UIButton) {
        fetchItems(sort: "asc")
        updateButtonStyles(selectedButton: sender)
    }

    // MARK: API 호출 및 데이터 가져오기
    private func fetchItems(sort: String) {
        manager.callRequest(searchKeyword, sort) { [weak self] searchResult in
            guard let self = self else { return }
            self.searchResult = searchResult
            self.items = searchResult.items ?? []
            
            if let totalNumber = searchResult.total {
                let formatter = NumberFormatter()
                formatter.numberStyle = .decimal
                let formattedCount = formatter.string(from: NSNumber(value: totalNumber)) ?? "\(totalNumber)"
                self.totalCountLabel.text = "\(formattedCount)개의 검색 결과"
            }

            self.itemCollectionView.reloadData()
        }
    }
    
    func configureView() {
        itemCollectionView.delegate = self
        itemCollectionView.dataSource = self
        
        let xib = UINib(nibName: "SearchResultCollectionViewCell", bundle: nil)
        itemCollectionView.register(xib, forCellWithReuseIdentifier: "SearchResultCollectionViewCell")
        
        updateButtonStyles(selectedButton: simSortButton)
    }
    
    func updateButtonStyles(selectedButton: UIButton) {
        let buttons = [simSortButton, dateSortButton, priceAscendingButton, priceDescendingButton]
        
        for button in buttons {
            if button == selectedButton {
                // 선택된 버튼: 흰 배경, 검은 글씨
                button?.backgroundColor = .white
                button?.setTitleColor(.black, for: .normal)
                button?.layer.borderWidth = 0
            } else {
                // 선택되지 않은 버튼: 검은 배경, 흰 글씨, 흰 border
                button?.backgroundColor = .black
                button?.setTitleColor(.white, for: .normal)
                button?.layer.borderWidth = 1
                button?.layer.borderColor = UIColor.white.cgColor
            }
            button?.layer.cornerRadius = 10
        }
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // MARK: 셀 선택시 웹뷰로 연결

        // 안전하게 배열에 접근
        if let productID = searchResult?.items?[indexPath.row].productID {
            // MARK: 검색 결과 화면으로 이동
            let viewController = storyboard?.instantiateViewController(identifier: ItemDetailViewController.identifier) as! ItemDetailViewController
            viewController.productId = productID
            navigationController?.pushViewController(viewController, animated: true)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // 화면 너비의 절반에서 30을 뺀 값
        let cellWidth = (collectionView.bounds.width / 2)
        // 셀 너비의 1.3배 높이
        let cellHeight = cellWidth * 1.3
        
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    // 라인 간격 설정 (수직 간격):
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    // 아이템 간격 설정 (수평 간격):
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    // 섹션 내부 여백 설정:
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
}

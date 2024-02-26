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
    
    let viewModel = SearchResultViewModel()
    
    let sectionInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    
    var items: [Item] = []
    var searchResult: Search?
    var searchKeyword: String = ""
    var sorting: String = "sim"
    
    var page = 1
    var isLastPage = false
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        itemCollectionView.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.titleView = UILabel.customNavigationTitle("\(viewModel.inputKeyword.value)")
        
        setBackGroundColor()
        configureView()
        
        bindViewModel()
        
        viewModel.inputKeyword.value = searchKeyword
        viewModel.fetchItems(sort: "sim")
        
        self.itemCollectionView.setContentOffset(CGPoint(x: 0, y: 0), animated: false)
        
        self.itemCollectionView.reloadData()
    }
    
    func bindViewModel() {
        viewModel.outputItems.bind { _ in
            DispatchQueue.main.async {
                self.items = self.viewModel.outputItems.value
                self.itemCollectionView.reloadData()
            }
        }
        
        viewModel.outputTotalCountLabel.bind { [weak self] totalCountText in
            DispatchQueue.main.async {
                self?.totalCountLabel.text = totalCountText
            }
        }
    }
    
    private func fetchItems(sort: String) {
        
        APISessionManager.shared.callRequest(type: Search.self, keyword: searchKeyword, sort: sort, page: 1) { item, error in
            
            guard let item = item else { return }
            
            if self.page == 1 {
                self.items = item.items ?? []
            } else {
                self.items.append(contentsOf: item.items ?? [])
            }
            
            if let totalNumber = item.total {
                let formatter = NumberFormatter()
                formatter.numberStyle = .decimal
                let formattedCount = formatter.string(from: NSNumber(value: totalNumber)) ?? "\(totalNumber)"
                self.totalCountLabel.text = "\(formattedCount)개의 검색 결과"
            }
            
            self.itemCollectionView.setContentOffset(CGPoint(x: 0, y: 0), animated: false)
            
            self.itemCollectionView.reloadData()
        }
    }
    
    // MARK: 상품 정렬 버튼 클릭 액션
    @IBAction func accuracySortButton(_ sender: UIButton) {
        viewModel.inputPage.value = 1
        viewModel.fetchItems(sort: "sim")
        updateButtonStyles(selectedButton: sender)
        sorting = "sim"
    }
    
    @IBAction func recentSortButton(_ sender: UIButton) {
        viewModel.inputPage.value = 1
        viewModel.fetchItems(sort: "date")
        bindViewModel()
        updateButtonStyles(selectedButton: sender)
        sorting = "date"
    }

    @IBAction func priceAscendingButton(_ sender: UIButton) {
        viewModel.inputPage.value = 1
        viewModel.fetchItems(sort: "dsc")
        bindViewModel()
        updateButtonStyles(selectedButton: sender)
        sorting = "dsc"
    }

    @IBAction func priceDescendingButton(_ sender: UIButton) {
        viewModel.inputPage.value = 1
        viewModel.fetchItems(sort: "asc")
        bindViewModel()
        updateButtonStyles(selectedButton: sender)
        sorting = "asc"
    }

    func configureView() {
        itemCollectionView.delegate = self
        itemCollectionView.dataSource = self
        
        let xib = UINib(nibName: "SearchResultCollectionViewCell", bundle: nil)
        itemCollectionView.register(xib, forCellWithReuseIdentifier: "SearchResultCollectionViewCell")
        
        updateButtonStyles(selectedButton: simSortButton)
    }
    
    // MARK: 정렬 버튼 디자인 로직
    func updateButtonStyles(selectedButton: UIButton) {
        let buttons = [simSortButton, dateSortButton, priceAscendingButton, priceDescendingButton]
        
        for button in buttons {
            if button == selectedButton {
                button?.backgroundColor = .white
                button?.setTitleColor(.black, for: .normal)
                button?.layer.borderWidth = 0
            } else {
                button?.backgroundColor = .black
                button?.setTitleColor(.white, for: .normal)
                button?.layer.borderWidth = 1
                button?.layer.borderColor = UIColor.white.cgColor
            }
            button?.layer.cornerRadius = 10
        }
    }
}

// MARK: collectionview 관련
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
        
        // MARK: 좋아요 버튼 관련 로직
        let productId = self.items[indexPath.item].productID
        var isLiked = UserDefaultsManager.shared.likedProducts[productId] ?? false
        cell.likeButton.setImage(UIImage(systemName: isLiked ? "heart.fill" : "heart"), for: .normal)
                
        cell.likeButtonTapped = {
            isLiked.toggle()
            var likedProducts = UserDefaultsManager.shared.likedProducts
            likedProducts[productId] = !(likedProducts[productId] ?? false)
            UserDefaultsManager.shared.likedProducts = likedProducts
            let isLikedNow = likedProducts[productId] ?? false
            cell.likeButton.setImage(UIImage(systemName: isLikedNow ? "heart.fill" : "heart"), for: .normal)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        let productID = self.items[indexPath.item].productID
        let productTitle = self.items[indexPath.item].title.replacingOccurrences(of: "<b>", with: "").replacingOccurrences(of: "</b>", with: "")
        let viewController = storyboard?.instantiateViewController(identifier: ItemDetailViewController.identifier) as! ItemDetailViewController
        viewController.productId = productID
        viewController.selectedItem = productTitle
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let width: CGFloat = UIScreen.main.bounds.width * 0.4
        let height: CGFloat = width * 1.6
        
        return CGSize(width: width, height: height)
    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        if indexPath.row == items.count - 1 && !isLastPage {
            page += 1
            fetchItems(sort: sorting)
        }
    }
}

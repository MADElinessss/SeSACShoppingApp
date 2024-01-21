//
//  SearchViewController.swift
//  SeSACShoppingApp
//
//  Created by Madeline on 2024/01/18.
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var eraseAllButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var emptyView: UIView!
    @IBOutlet weak var emptyImageView: UIImageView!
    @IBOutlet weak var emptyLabel: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    var userName: String = "고객"
    
    var list: [String] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    var originalList: [String] = []
    
    var itemList: [Item] = []
 
    let manager = APIManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        list = UserDefaultsManager.shared.searchHistory
        
        updateEmptyView()
        setBackGroundColor()
        configureView()
        configureEmptyView()
        configureTableView()
    }
    
    // TODO: 검색 기록 모두 삭제 버튼임
    @IBAction func eraseAllButtonTapped(_ sender: UIButton) {
        UserDefaultsManager.shared.searchHistory = []
        list = []
        tableView.reloadData()
    }
    
    // MARK: 검색어 저장의 기준을 못찾아서 만듦,,🥲
    @IBAction func searchButtonTapped(_ sender: UIButton) {
        // MARK: 검색한 단어 -> 이전 검색 기록에 저장
        if let searchText = searchBar.text, !searchText.isEmpty {
            
            var currentHistory = UserDefaultsManager.shared.searchHistory
            
            // MARK: 중복 검사 - 중복된 값이 없을 때만 추가
            if !currentHistory.contains(searchText) {
                currentHistory.append(searchText)
                UserDefaultsManager.shared.searchHistory = currentHistory
            }
            
            list = currentHistory
            tableView.reloadData()
            
            view.endEditing(true)
            
            let viewController = storyboard?.instantiateViewController(identifier: SearchResultViewController.identifier) as! SearchResultViewController
            viewController.searchKeyword = searchText
            navigationController?.pushViewController(viewController, animated: true)
        }
    }
    
    func updateEmptyView() {
        // TODO: 검색 결과가 있으면 toggle
        if list.count == 0 {
            emptyView.isHidden = false
            tableView.isHidden = true
            eraseAllButton.isHidden = true
            titleLabel.isHidden = true
        } else {
            emptyView.isHidden = true
            tableView.isHidden = false
            eraseAllButton.isHidden = false
            titleLabel.isHidden = false
        }
        tableView.reloadData()
    }

    func configureEmptyView() {
        emptyView.backgroundColor = .black
        emptyLabel.textColor = .white
        emptyLabel.font = .systemFont(ofSize: 18, weight: .semibold)
        emptyImageView.image = UIImage(named: "empty")
    }
    
    func configureView() {
        
//        title = "\(userName)님의 새싹쇼핑"
        
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        self.navigationItem.hidesBackButton = true
        
        searchBar.barTintColor = .black
        searchBar.placeholder = "브랜드, 상품, 프로필, 태그 등"
        if let textfield = searchBar.value(forKey: "searchField") as? UITextField {
            textfield.backgroundColor = UIColor.darkGray
            textfield.attributedPlaceholder = NSAttributedString(string: textfield.placeholder ?? "", attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray])
            textfield.textColor = UIColor.white
            if let leftView = textfield.leftView as? UIImageView {
                leftView.image = leftView.image?.withRenderingMode(.alwaysTemplate)
                leftView.tintColor = UIColor.lightGray
            }
        }
    }
    
    func configureTableView() {
        tableView.backgroundColor = .black
        
        tableView.delegate = self
        tableView.dataSource = self
        
        let xib = UINib(nibName: TableViewCell.identifier, bundle: nil)
        tableView.register(xib, forCellReuseIdentifier: TableViewCell.identifier)
    }
}

// MARK: TableView
extension SearchViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.identifier) as! TableViewCell
        
        cell.historyLabel.text = list[indexPath.row]
        cell.deleteButtonTappedHandler = { [weak self] in
            self?.deleteSearchHistoryItem(at: indexPath.row)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedKeyword = list[indexPath.row]
        searchBar.text = selectedKeyword
        
        let viewController = storyboard?.instantiateViewController(identifier: SearchResultViewController.identifier) as! SearchResultViewController
        viewController.searchKeyword = searchBar.text ?? ""
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    func deleteSearchHistoryItem(at index: Int) {
        
        list.remove(at: index)
        UserDefaultsManager.shared.searchHistory = list
        
        tableView.reloadData()
        updateEmptyView()
    }
}

// MARK: SearchBar
extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        updateEmptyView()
        
        if searchText.isEmpty {
            list = UserDefaultsManager.shared.searchHistory
        } else {
            list = UserDefaultsManager.shared.searchHistory.filter { $0.contains(searchText) }
        }
    }
}

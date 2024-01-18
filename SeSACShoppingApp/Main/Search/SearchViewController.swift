//
//  SearchViewController.swift
//  SeSACShoppingApp
//
//  Created by Madeline on 2024/01/18.
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var emptyView: UIView!
    @IBOutlet weak var emptyImageView: UIImageView!
    @IBOutlet weak var emptyLabel: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    var userName: String = "고객"
    
    var list: [String] = ["맥북 거치대", "고무장갑"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setBackGroundColor()
        configureView()
        configureEmptyView()
        configureTableView()
        
        // TODO: 검색 결과가 있으면 toggle
        emptyView.isHidden = true
    }
    
    // TODO: 검색 기록 모두 삭제 버튼임
    @IBAction func eraseAllButtonTapped(_ sender: UIButton) {
        
        view.endEditing(true)
    }
    
    func configureEmptyView() {
        emptyView.backgroundColor = .black
        emptyLabel.textColor = .white
        emptyLabel.font = .systemFont(ofSize: 18, weight: .semibold)
        emptyImageView.image = UIImage(named: "empty")
    }
    
    func configureView() {
        
        title = "\(userName)님의 새싹쇼핑"
        
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        let backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        backBarButtonItem.tintColor = .black
        self.navigationItem.backBarButtonItem = backBarButtonItem
        
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
            if let rightView = textfield.rightView as? UIImageView {
                rightView.image = rightView.image?.withRenderingMode(.alwaysTemplate)
                rightView.tintColor = UIColor.white
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

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.identifier) as! TableViewCell
        
        cell.historyLabel.text = list[indexPath.row]
        print(list[indexPath.row])
        return cell
    }
}

extension SearchViewController: UISearchBarDelegate {
    
}

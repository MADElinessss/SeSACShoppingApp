//
//  CodeBasedSearchViewController.swift
//  SeSACShoppingApp
//
//  Created by Madeline on 1/27/24.
//

import SnapKit
import UIKit

class CodeBasedSearchViewController: UIViewController {
    
    let titleLabel = UILabel()
    let searchBar = UISearchBar()
    let leftSubtitle = UILabel()
    let rightSubtitleButton = UIButton()
    let tableview = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        configureHierarchy()
        setConstraints()
    }
    
    func configureView() {
        
        view.backgroundColor = .black
        
        titleLabel.text = "떠나고 싶은 고래밥님의 새싹쇼핑"
        titleLabel.textColor = .white
        titleLabel.font = .systemFont(ofSize: 22, weight: .bold)
        
        searchBar.searchTextField.backgroundColor = UIColor(named: "darkerGray")
        searchBar.barTintColor = .clear
        searchBar
            .searchTextField
            .attributedPlaceholder = NSAttributedString(
                string: "브랜드, 상품, 프로필, 태그 등",
                attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray]
            )
        searchBar.searchTextField.leftView?.tintColor = .lightGray
        
        leftSubtitle.text = "최근 검색"
        leftSubtitle.textColor = .white
        leftSubtitle.font = .systemFont(ofSize: 16, weight: .bold)
        
        rightSubtitleButton.setTitle("모두 지우기", for: .normal)
        rightSubtitleButton.setTitleColor(UIColor(named: "point"), for: .normal)
        rightSubtitleButton.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        
        tableview.delegate = self
        tableview.dataSource = self
        tableview.register(CodeBasedSearchTableViewCell.self, forCellReuseIdentifier: "CodeBasedSearchTableViewCell")
        
        tableview.backgroundColor = .black
        
    }
    
    func configureHierarchy() {
        view.addSubview(titleLabel)
        view.addSubview(searchBar)
        view.addSubview(leftSubtitle)
        view.addSubview(rightSubtitleButton)
        view.addSubview(tableview)
    }
    
    func setConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.centerX.equalTo(view)
        }
        
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).inset(-16)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
        }
        
        leftSubtitle.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom).inset(-18)
            make.leading.equalTo(view.safeAreaLayoutGuide).inset(8)
        }
        
        rightSubtitleButton.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom).inset(-18)
            make.trailing.equalTo(view.safeAreaLayoutGuide).inset(8)
        }
        
        tableview.snp.makeConstraints { make in
            make.horizontalEdges.bottom.equalToSuperview()
            make.top.equalTo(200)
        }
    }
}

extension CodeBasedSearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CodeBasedSearchTableViewCell", for: indexPath) as! CodeBasedSearchTableViewCell
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    
    
}

#Preview {
    CodeBasedSearchViewController()
}

//
//  CodeBasedSearchTableViewCell.swift
//  SeSACShoppingApp
//
//  Created by Madeline on 1/27/24.
//

import SnapKit
import UIKit

class CodeBasedSearchTableViewCell: UITableViewCell {
    
    let contentLabel = UILabel()
    let leftIcon = UIImageView()
    let rightButton = UIButton()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super .init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = .black
        
        contentView.addSubview(contentLabel)
        contentView.addSubview(leftIcon)
        contentView.addSubview(rightButton)
        
        contentLabel.text = "최근검색어1"
        contentLabel.textColor = .white
        contentLabel.font = .systemFont(ofSize: 12, weight: .medium)
        
        leftIcon.image = UIImage(systemName: "magnifyingglass")
        leftIcon.tintColor = .white
        
        rightButton.setImage(UIImage(systemName: "xmark"), for: .normal)
        rightButton.tintColor = .lightGray
        
        leftIcon.snp.makeConstraints { make in
            make.top.equalTo(24)
            make.leading.equalTo(24)
            make.height.equalTo(20)
        }
        contentLabel.snp.makeConstraints { make in
            make.leading.equalTo(100)
            make.top.equalTo(26)
            make.width.equalTo(200)
        }
        
        rightButton.snp.makeConstraints { make in
            make.trailing.equalTo(-16)
            make.top.equalTo(24)
            make.width.equalTo(30)
        }
        

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

#Preview {
    CodeBasedSearchTableViewCell()
}

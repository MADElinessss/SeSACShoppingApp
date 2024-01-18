//
//  ProfileImageSelectViewController.swift
//  SeSACShoppingApp
//
//  Created by Madeline on 2024/01/18.
//

import UIKit

class ProfileImageSelectViewController: UIViewController {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var completeButton: UIButton!
    
    var selectedImage: String = "profile1"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setBackGroundColor()
        configureView()
        configureCollectionView()
        
    }
    
    func configureView() {
        
        profileImageView.image = UIImage(named: "\(selectedImage)")
        profileImageView.clipsToBounds = true
        profileImageView.layer.cornerRadius = 65
        profileImageView.layer.borderColor = UIColor(named: "point")?.cgColor
        profileImageView.layer.borderWidth = 6
        
        // TODO: 디자인 시스템으로 뺄 것,,
        completeButton.setTitle("완료", for: .normal)
        completeButton.tintColor = .white
        completeButton.titleLabel?.font = .boldSystemFont(ofSize: 18)
        completeButton.backgroundColor = UIColor(named: "point")
        completeButton.layer.cornerRadius = 10
        
    }
}

extension ProfileImageSelectViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func configureCollectionView() {
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.backgroundColor = .black
        
        let xib = UINib(nibName: ProfileCollectionViewCell.identifier, bundle: nil)
        collectionView.register(xib, forCellWithReuseIdentifier: ProfileCollectionViewCell.identifier)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 14
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProfileCollectionViewCell", for: indexPath) as! ProfileCollectionViewCell
        
        cell.profileButton.setImage(UIImage(named: "profile\(indexPath.item+1)"), for: .normal)
        cell.profileButton.clipsToBounds = true
        cell.profileButton.layer.cornerRadius = 50
        cell.profileButton.layer.borderColor = UIColor(named: "point")?.cgColor
        cell.profileButton.layer.borderWidth = 6
        
        return cell
    }
}

//
//  ProfileImageSelectViewController.swift
//  SeSACShoppingApp
//
//  Created by Madeline on 2024/01/18.
//

import UIKit

// MARK: 프로필 이미지 정하는 화면
class ProfileImageSelectViewController: UIViewController {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var completeButton: UIButton!
    
    let viewModel = ProfileImageSelectViewModel()
    
    var savedProfileImage: String = UserDefaultsManager.shared.selectedImage {
        didSet {
            profileImageView.reloadInputViews()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setBackGroundColor()
        configureView()
        configureCollectionView()
        navigationItem.titleView = UILabel.customNavigationTitle("프로필 이미지 설정")
        
        profileImageView.image = UIImage(named: viewModel.selectedImage.value)
    }
    
    @IBAction func completeButtonTapped(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    func configureView() {
        
        profileImageView.image = UIImage(named: viewModel.selectedImage.value)
        profileImageView.clipsToBounds = true
        profileImageView.layer.cornerRadius = 65
        profileImageView.layer.borderColor = UIColor(named: "point")?.cgColor
        profileImageView.layer.borderWidth = 6
        
        completeButton.customButton("완료")
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

        cell.profileImageView.image = UIImage(named: "profile\(indexPath.row + 1)")
        cell.profileImageView.layer.cornerRadius = 30
        cell.profileImageView.isUserInteractionEnabled = true

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        cell.profileImageView.addGestureRecognizer(tapGesture)
        cell.profileImageView.tag = indexPath.row

        return cell
    }

    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        if let tappedImageView = sender.view as? UIImageView {
            let tappedIndex = tappedImageView.tag
            
            // TODO: 버튼 탭했따 Trigger -> ViewModel
            viewModel.profileButtonTapped.value = "profile\(tappedIndex + 1)"
            
            profileImageView.image = UIImage(named: viewModel.selectedImage.value)

            for i in 0..<collectionView.numberOfItems(inSection: 0) {
                if let cell = collectionView.cellForItem(at: IndexPath(item: i, section: 0)) as? ProfileCollectionViewCell {
                    cell.profileImageView.layer.borderColor = (i == tappedIndex) ? UIColor(named: "point")?.cgColor : UIColor.clear.cgColor
                    cell.profileImageView.layer.borderWidth = 4
                }
            }
        }
    }
}

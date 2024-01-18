//
//  ProfileSettingViewController.swift
//  SeSACShoppingApp
//
//  Created by Madeline on 2024/01/18.
//

import UIKit

class ProfileSettingViewController: UIViewController {

    @IBOutlet weak var profileButton: UIButton!
    @IBOutlet weak var nicknameTextField: UITextField!
    @IBOutlet weak var warningLabel: UILabel!
    @IBOutlet weak var completeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setBackGroundColor()
        configureView()

    }
    
    @IBAction func profileButtonTapped(_ sender: UIButton) {
        let viewController = storyboard?.instantiateViewController(withIdentifier: ProfileImageSelectViewController.identifier) as! ProfileImageSelectViewController
        
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    @IBAction func completeButtonTapped(_ sender: UIButton) {
        
        let viewController = storyboard?.instantiateViewController(withIdentifier: SearchViewController.identifier) as! SearchViewController
        
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func configureView() {
        
        navigationItem.title = "프로필 설정"
        navigationItem.titleView?.tintColor = UIColor(named: "point")
        
        let random = Int.random(in: 1...14)
        profileButton.setImage(UIImage(named: "profile\(random)"), for: .normal)
        profileButton.clipsToBounds = true
        profileButton.layer.cornerRadius = 65
        profileButton.layer.borderColor = UIColor(named: "point")?.cgColor
        profileButton.layer.borderWidth = 6
        
        nicknameTextField.attributedPlaceholder = NSAttributedString(string: "닉네임을 입력해주세요 :)", attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray])
        nicknameTextField.textColor = .white
        
        warningLabel.text = "닉네임에 @는 포함할 수 없어요."
        warningLabel.textColor = UIColor(named: "point")
        warningLabel.font = .systemFont(ofSize: 12, weight: .medium)
        
        
        completeButton.setTitle("완료", for: .normal)
        completeButton.tintColor = .white
        completeButton.titleLabel?.font = .boldSystemFont(ofSize: 18)
        completeButton.backgroundColor = UIColor(named: "point")
        completeButton.layer.cornerRadius = 10
        
        let backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        backBarButtonItem.tintColor = .white
        self.navigationItem.backBarButtonItem = backBarButtonItem
    
    }
}

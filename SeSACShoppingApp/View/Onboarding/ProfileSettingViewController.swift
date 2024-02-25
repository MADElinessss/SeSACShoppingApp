//
//  ProfileSettingViewController.swift
//  SeSACShoppingApp
//
//  Created by Madeline on 2024/01/18.
//

import UIKit

enum ValidationError: Error {
    case containsCharacter(character: Character)
    case containsInt
    case wrongLength
}

// MARK: 프로필 + 닉네임 설정
class ProfileSettingViewController: UIViewController {
    
    @IBOutlet weak var profileButton: UIButton!
    @IBOutlet weak var nicknameTextField: UITextField!
    @IBOutlet weak var warningLabel: UILabel!
    @IBOutlet weak var completeButton: UIButton!
    @IBOutlet var tapGestureRecognizerTapped: UITapGestureRecognizer!
    
    var cameFromOnboarding: Bool = false
    
    let viewModel = ProfileViewModel()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel.savedProfileImage.value = UserDefaultsManager.shared.selectedImage

        profileButton.setImage(UIImage(named: viewModel.savedProfileImage.value), for: .normal)

        navigationItem.titleView = UILabel.customNavigationTitle("프로필 설정")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        completeButton.isEnabled = false
        setBackGroundColor()
        configureView()
        nicknameTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        
        guard let text = textField.text else { return }
        
        do {
            let result = try validateUserInputError(text)
        } catch {
            switch error {
            case ValidationError.containsCharacter(let character):
                warningLabel.text = "닉네임에 \(character)는 포함할 수 없어요."
                completeButton.isEnabled = false
                return
            case ValidationError.containsInt:
                warningLabel.text = "닉네임에 숫자는 포함할 수 없어요."
                completeButton.isEnabled = false
                return
            case ValidationError.wrongLength:
                warningLabel.text = "2글자 이상 10글자 미만으로 설정해주세요."
                completeButton.isEnabled = false
                return
            default:
                print("default")
            }
        }
   
        warningLabel.text = "사용할 수 있는 닉네임이에요."
        completeButton.isEnabled = true
        
    }
    
    func validateUserInputError(_ text: String) throws -> Bool {
        
        guard text.count >= 2 && text.count < 10 else {
            throw ValidationError.wrongLength
        }
        
        let digitCharacterSet = CharacterSet.decimalDigits
        guard text.rangeOfCharacter(from: digitCharacterSet) == nil else {
            throw ValidationError.containsInt
        }
        
        let specialCharacters = "@#$%"
        for character in text {
            guard !specialCharacters.contains(character) else {
                throw ValidationError.containsCharacter(character: character)
            }
        }
        
        return true
    }
    
    @IBAction func tapGestureRecognizerTapped(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    @IBAction func profileButtonTapped(_ sender: UIButton) {
        let viewController = storyboard?.instantiateViewController(withIdentifier: ProfileImageSelectViewController.identifier) as! ProfileImageSelectViewController
        
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    @IBAction func completeButtonTapped(_ sender: UIButton) {
        
        UserDefaultsManager.shared.userName = nicknameTextField.text ?? "고객님"
        UserDefaultsManager.shared.selectedImage = viewModel.fetchedProfileImage.value
        
        if cameFromOnboarding {
            // 온보딩 뷰에서 왔을 경우
            let sb = UIStoryboard(name: "Main", bundle: nil)
            let vc = sb.instantiateViewController(withIdentifier: "mainTabBarController") as! UITabBarController
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true)
        } else {
            // 설정 뷰에서 왔을 경우
            navigationController?.popViewController(animated: true)
        }
    }

    func configureView() {
        
        title = "프로필 설정"
        
        navigationItem.titleView?.tintColor = UIColor(named: "point")
        
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0.0, y: nicknameTextField.frame.height + 10, width: nicknameTextField.frame.width, height: 1.0)
        bottomLine.backgroundColor = UIColor.white.cgColor
        nicknameTextField.borderStyle = .none
        nicknameTextField.layer.addSublayer(bottomLine)
        if UserDefaultsManager.shared.userName != "고객" {
            nicknameTextField.text = UserDefaultsManager.shared.userName
        }
    
        profileButton.setImage(UIImage(named: viewModel.fetchedProfileImage.value), for: .normal)
        profileButton.clipsToBounds = true
        profileButton.layer.cornerRadius = 65
        profileButton.layer.borderColor = UIColor(named: "point")?.cgColor
        profileButton.layer.borderWidth = 6
        
        nicknameTextField.attributedPlaceholder = NSAttributedString(string: "닉네임을 입력해주세요 :)", attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray])
        nicknameTextField.textColor = .white
        
        warningLabel.text = ""
        warningLabel.textColor = UIColor(named: "point")
        warningLabel.font = .systemFont(ofSize: 12, weight: .medium)
        
        completeButton.customButton("완료")
        
        let backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        backBarButtonItem.tintColor = .white
        self.navigationItem.backBarButtonItem = backBarButtonItem
        
    }
}

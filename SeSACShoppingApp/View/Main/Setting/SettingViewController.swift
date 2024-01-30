//
//  SettingViewController.swift
//  SeSACShoppingApp
//
//  Created by Madeline on 2024/01/18.
//

import UIKit

class SettingViewController: UIViewController {
    
    @IBOutlet weak var settingtableView: UITableView!
    
    var selectedImage = UserDefaultsManager.shared.selectedImage {
        didSet {
            settingtableView.reloadData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        settingtableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()
        setBackGroundColor()
        
    }
    
    func configureTableView() {
        
        settingtableView.delegate = self
        settingtableView.dataSource = self
        
        let xib1 = UINib(nibName: "SettingsTableViewCell", bundle: nil)
        settingtableView.register(xib1, forCellReuseIdentifier: "SettingsTableViewCell")
        
        let xib2 = UINib(nibName: "SettingsProfileTableViewCell", bundle: nil)
        settingtableView.register(xib2, forCellReuseIdentifier: "SettingsProfileTableViewCell")
        
        settingtableView.backgroundColor = UIColor.black
    }
}

extension SettingViewController: UITableViewDelegate, UITableViewDataSource {
    
    enum Section: Int, CaseIterable {
        case profile
        case settings
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return Section.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch Section(rawValue: section) {
        case .profile:
            return 1
        case .settings:
            return 5
        case .none:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch Section(rawValue: indexPath.section) {
        case .profile:
            let identifier = String(describing: SettingsProfileTableViewCell.self)
            let cell = settingtableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! SettingsProfileTableViewCell
            
            let image = UserDefaultsManager.shared.selectedImage
            cell.profileImageView.image = UIImage(named: "\(image)")
            cell.profileImageView.clipsToBounds = true
            cell.profileImageView.layer.cornerRadius = 25
            cell.profileImageView.layer.borderColor = UIColor(named: "point")?.cgColor
            cell.profileImageView.layer.borderWidth = 4
            
            cell.userNameLabel.text = UserDefaultsManager.shared.userName
            
            let totalLikedProducts = UserDefaultsManager.shared.likedProducts.values.filter { $0 }.count
            cell.itemCountLabel.text = "\(totalLikedProducts)개의 상품"
            
            cell.backgroundColor = UIColor(named: "darkerGray")
            return cell
            
        case .settings:
            let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsTableViewCell", for: indexPath) as! SettingsTableViewCell
            cell.titleLabel.text = Settings[indexPath.row]
            cell.tintColor = .lightGray
            cell.backgroundColor = UIColor(named: "darkerGray")
            return cell
        case .none:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.section == 0 {
            let sb = UIStoryboard(name: "Onboarding", bundle: nil)
            let vc = sb.instantiateViewController(withIdentifier: ProfileSettingViewController.identifier) as! ProfileSettingViewController
            vc.cameFromOnboarding = false
            navigationController?.pushViewController(vc, animated: true)
        } else if indexPath.row == 4 {
            
            let alert = UIAlertController(title: "처음부터 시작하기", message: "데이터를 모두 초기화하시겠습니까?🥹", preferredStyle: .alert)
            
            let okay = UIAlertAction(title: "확인", style: .default) { action in
                
                if let bundleID = Bundle.main.bundleIdentifier {
                    UserDefaults.standard.removePersistentDomain(forName: bundleID)
                    UserDefaults.standard.synchronize()
                }
                
                let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
                let sceneDelegate = windowScene?.delegate as? SceneDelegate
                
                let sb = UIStoryboard(name: "Onboarding", bundle: nil)
                let vc = sb.instantiateViewController(withIdentifier: OnboardingViewController.identifier) as! OnboardingViewController
                
                let nav = UINavigationController(rootViewController: vc)
                
                sceneDelegate?.window?.rootViewController = nav
                sceneDelegate?.window?.makeKeyAndVisible()
            }
            let cancel = UIAlertAction(title: "취소", style: .cancel)
            
            alert.addAction(okay)
            alert.addAction(cancel)
            
            self.present(alert, animated: true)
        } else {
            
        }
    }
    
    // 나머지 설정 셀 비활성화
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        if indexPath.section == 1 && indexPath.row >= 0 && indexPath.row <= 3 {
            return false
        }
        return true
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 80
        } else {
            return 44
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 8
    }
}

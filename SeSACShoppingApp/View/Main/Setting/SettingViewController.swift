//
//  SettingViewController.swift
//  SeSACShoppingApp
//
//  Created by Madeline on 2024/01/18.
//

import UIKit

class SettingViewController: UIViewController {

    @IBOutlet weak var settingtableView: UITableView!
    
    var selectedImage = UserDefaults.standard.string(forKey: "selectedImage") ?? "profile1"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()
        
        setBackGroundColor()
        
        settingtableView.backgroundColor = UIColor.black
    }
    
    func configureTableView() {
        
        settingtableView.delegate = self
        settingtableView.dataSource = self
        
        let xib1 = UINib(nibName: "SettingsTableViewCell", bundle: nil)
        settingtableView.register(xib1, forCellReuseIdentifier: "SettingsTableViewCell")
        
        let xib2 = UINib(nibName: "SettingsProfileTableViewCell", bundle: nil)
        settingtableView.register(xib2, forCellReuseIdentifier: "SettingsProfileTableViewCell")
    }
}

extension SettingViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return 5
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell = settingtableView.dequeueReusableCell(withIdentifier: "SettingsProfileTableViewCell", for: indexPath) as! SettingsProfileTableViewCell
            cell.profileImageView.image = UIImage(named: "\(selectedImage)")
            cell.profileImageView.clipsToBounds = true
            cell.profileImageView.layer.cornerRadius = 25
            cell.profileImageView.layer.borderColor = UIColor(named: "point")?.cgColor
            cell.profileImageView.layer.borderWidth = 4
            cell.backgroundColor = UIColor(named: "darkerGray")
            cell.layer.cornerRadius = 10
            return cell
        } else {
            let cell = settingtableView.dequeueReusableCell(withIdentifier: "SettingsTableViewCell", for: indexPath) as! SettingsTableViewCell
            
            cell.titleLabel.text = Settings[indexPath.row]
            cell.tintColor = .lightGray
            cell.backgroundColor = UIColor(named: "darkerGray")
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            let sb = UIStoryboard(name: "Onboarding", bundle: nil)
            let vc = sb.instantiateViewController(withIdentifier: ProfileSettingViewController.identifier) as! ProfileSettingViewController
        
            navigationController?.pushViewController(vc, animated: true)
        } else if indexPath.row == 4 {
            
            let alert = UIAlertController(title: "처음부터 시작하기", message: "데이터를 모두 초기화하시겠습니까?🥹", preferredStyle: .alert)
            
            let okay = UIAlertAction(title: "확인", style: .default) { action in
                UserDefaults.standard.setValue(false, forKey: "UserState")
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

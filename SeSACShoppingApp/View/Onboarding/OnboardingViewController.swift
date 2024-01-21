//
//  OnboardingViewController.swift
//  SeSACShoppingApp
//
//  Created by Madeline on 2024/01/18.
//

import UIKit

class OnboardingViewController: UIViewController {

    @IBOutlet weak var appNameLabel: UILabel!
    @IBOutlet weak var onboardingImageView: UIImageView!
    @IBOutlet weak var startButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        setBackGroundColor()
        UserDefaults.standard.set(true, forKey: "UserState")
    }
    
    @IBAction func startButtonTapped(_ sender: UIButton) {
        let viewController = storyboard?.instantiateViewController(withIdentifier: ProfileSettingViewController.identifier) as! ProfileSettingViewController
        
        navigationController?.pushViewController(viewController, animated: true)

    }
    
    func configureView() {
        
        appNameLabel.text = "SeSAC Shopping"
        appNameLabel.font = .boldSystemFont(ofSize: 40)
        appNameLabel.numberOfLines = 2
        appNameLabel.textColor = UIColor(named: "point")
        
        onboardingImageView.image = UIImage(named: "onboarding")
        
        startButton.setTitle("시작하기", for: [])
        startButton.tintColor = .white
        startButton.titleLabel?.font = .boldSystemFont(ofSize: 18)
        startButton.backgroundColor = UIColor(named: "point")
        startButton.layer.cornerRadius = 10
        
        let backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        backBarButtonItem.tintColor = .white
        self.navigationItem.backBarButtonItem = backBarButtonItem
        
    }
}

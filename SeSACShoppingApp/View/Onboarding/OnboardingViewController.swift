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
        
        UserDefaultsManager.shared.userState = true
    }
    
    @IBAction func startButtonTapped(_ sender: UIButton) {
        
        let viewController = storyboard?.instantiateViewController(withIdentifier: ProfileSettingViewController.identifier) as! ProfileSettingViewController
        viewController.cameFromOnboarding = true
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func configureView() {
        
        appNameLabel.text = "SeSAC Shopping"
        appNameLabel.font = .boldSystemFont(ofSize: 40)
        appNameLabel.numberOfLines = 2
        appNameLabel.textColor = UIColor(named: "point")
        
        onboardingImageView.image = UIImage(named: "onboarding")
        
        startButton.customButton("시작하기")
        
        let backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        backBarButtonItem.tintColor = .white
        self.navigationItem.backBarButtonItem = backBarButtonItem
        
    }
}

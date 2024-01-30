//
//  CodeBasedOnboardingViewController.swift
//  SeSACShoppingApp
//
//  Created by Madeline on 1/30/24.
//

import UIKit

class CodeBasedOnboardingViewController: UIViewController {
    
    let appNameLabel = UILabel()
    let startButton = SSButton()
    let onboardingImageView = UIImageView()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureHierarchy()
        configureView()
        configureLayout()
        
        setBackGroundColor()
    }
    

    func configureHierarchy() {
        view.addSubview(startButton)
        view.addSubview(appNameLabel)
        view.addSubview(onboardingImageView)
    }
    
    func configureView() {
        
        appNameLabel.text = "SeSAC Shopping"
        appNameLabel.font = .boldSystemFont(ofSize: 40)
        appNameLabel.numberOfLines = 2
        appNameLabel.textColor = UIColor(named: "point")
        appNameLabel.textAlignment = .center
        
        onboardingImageView.image = UIImage(named: "onboarding")
        
        startButton.cornerRadius = 10
        startButton.text = "시작하기"
    }
    
    func configureLayout() {
        
        appNameLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(50)
            make.centerX.equalTo(view)
            make.width.equalTo(UIScreen.main.bounds.width * 0.5)
        }
        
        onboardingImageView.snp.makeConstraints { make in
            make.centerY.equalTo(view)
            make.centerX.equalTo(view)
        }
        
        startButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(32)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(8)
            make.height.equalTo(50)
        }
    }

}

#Preview {
    CodeBasedOnboardingViewController()
}

//
//  SceneDelegate.swift
//  SeSACShoppingApp
//
//  Created by Madeline on 2024/01/18.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        let value = UserDefaults.standard.bool(forKey: "UserState")
        if !value {
            guard let scene = (scene as? UIWindowScene) else { return }

            window = UIWindow(windowScene: scene)

            let sb = UIStoryboard(name: "Onboarding", bundle: nil)
            let viewController = sb.instantiateViewController(withIdentifier: OnboardingViewController.identifier) as! OnboardingViewController
            
            let nav = UINavigationController(rootViewController: viewController)

            window?.rootViewController = nav
            
            window?.makeKeyAndVisible()

        } else {
            // MARK: 첫 진입 아니면 -> 메인 화면
            guard let scene = (scene as? UIWindowScene) else { return }

            window = UIWindow(windowScene: scene)
            
            // MARK: 메인화면이 탭바 전체
            
            let sb = UIStoryboard(name: "Main", bundle: nil)
            let vc = sb.instantiateViewController(withIdentifier: "mainTabBarController") as! UITabBarController

            window?.rootViewController = vc
            
            window?.makeKeyAndVisible()
        }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
    }

    func sceneWillResignActive(_ scene: UIScene) {
        
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        
    }


}


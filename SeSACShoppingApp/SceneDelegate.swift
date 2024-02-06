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
        
        let value = UserDefaultsManager.shared.userState
        print(value)
        
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
        
//        guard let scene = (scene as? UIWindowScene) else {
//            print("Scene casting to UIWindowScene failed")
//            return
//        }
//        
//        window = UIWindow(windowScene: scene)
//        
//        if !value {
//            print("User state is false - navigating to Onboarding")
//            
//            let sb = UIStoryboard(name: "Onboarding", bundle: nil)
//            
//            guard let viewController = sb.instantiateViewController(withIdentifier: OnboardingViewController.identifier) as? OnboardingViewController else {
//                print("Could not instantiate OnboardingViewController from storyboard")
//                return
//            }
//            
//            let nav = UINavigationController(rootViewController: viewController)
//            window?.rootViewController = nav
//            
//        } else {
//
//            let tabBarController = UITabBarController()
//            
//            
//            let searchVC = CodeBasedSearchViewController()
//            searchVC.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
//            
//            let settingsVC = CodeBasedSettingsViewController()
//            settingsVC.tabBarItem = UITabBarItem(tabBarSystemItem: .more, tag: 1)
//            
//            tabBarController.viewControllers = [searchVC, settingsVC].map { UINavigationController(rootViewController: $0) }
//
//            window?.rootViewController = tabBarController
//            
//        }
//        if let tabBarController = window?.rootViewController as? UITabBarController {
//            let appearance = UITabBarAppearance()
//            appearance.configureWithOpaqueBackground()
//            appearance.backgroundColor = .black
//
//            appearance.stackedLayoutAppearance.normal.iconColor = .gray
//            appearance.stackedLayoutAppearance.normal.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.gray]
//
//            appearance.stackedLayoutAppearance.selected.iconColor = UIColor(named: "point")
//            appearance.stackedLayoutAppearance.selected.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(named: "point")!]
//
//            tabBarController.tabBar.standardAppearance = appearance
//            if #available(iOS 15.0, *) {
//                tabBarController.tabBar.scrollEdgeAppearance = appearance
//            }
//        }
//        window?.makeKeyAndVisible()
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


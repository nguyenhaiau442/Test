//
//  AppDelegate.swift
//  Test
//
//  Created by Nguyễn Hải Âu on 10/21/20.
//  Copyright © 2020 Nguyễn Hải Âu. All rights reserved.
//

import UIKit

enum ScreenType {
    case login
    case tabbar
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let userDefault = UserDefaults.standard

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        
        if userDefault.bool(forKey: isLogged) == true {
            changeScreen(screenType: .tabbar)
        } else {
            changeScreen(screenType: .login)
        }
        
        return true
    }
    
    func createTabbar() {
        let homeVC = HomeViewController()
        homeVC.tabBarItem = UITabBarItem(title: "Home", image: #imageLiteral(resourceName: "home"), selectedImage: #imageLiteral(resourceName: "home_selected"))
        
        let settingVC = SettingViewController()
        settingVC.tabBarItem = UITabBarItem(title: "Setting", image: #imageLiteral(resourceName: "setting"), selectedImage: #imageLiteral(resourceName: "setting_selected"))
        
        let tabarController = UITabBarController()
        tabarController.viewControllers = [homeVC, settingVC]
        
        window?.rootViewController = tabarController
    }
    
    func createLogin() {
        let loginVC = LoginViewController()
        window?.rootViewController = loginVC
    }
    
    func changeScreen(screenType: ScreenType) {
        switch screenType {
        case .login:
            createLogin()
        case .tabbar:
            createTabbar()
        }
    }

}


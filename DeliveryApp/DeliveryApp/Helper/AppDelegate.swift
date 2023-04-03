//
//  AppDelegate.swift
//  DeliveryApp
//
//  Created by Abduraxmon on 03/04/23.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow()
        
        let mainPageVC = MainPageVC(nibName: "MainPageVC", bundle: nil)
        let contactVC = ContactVC(nibName: "ContactVC", bundle: nil)
        let profileVC = PtofileVC(nibName: "PtofileVC", bundle: nil)
        let cartVC = CartVC(nibName: "CartVC", bundle: nil)
        
        let item1 = UITabBarItem()
        let item2 = UITabBarItem()
        let item3 = UITabBarItem()
        let item4 = UITabBarItem()
        
        item1.image = UIImage(named: "1")
        item2.image = UIImage(named: "2")
        item3.image = UIImage(named: "3")
        item4.image = UIImage(named: "4")
        
        item1.title = "Меню"
        item2.title = "Контаты"
        item3.title = "Пофиль"
        item4.title = "Корзина"
        
        mainPageVC.tabBarItem = item1
        contactVC.tabBarItem = item2
        profileVC.tabBarItem = item3
        cartVC.tabBarItem = item4
        
        let tabBarController = UITabBarController()
        tabBarController.tabBar.tintColor = #colorLiteral(red: 0.9918184876, green: 0.229468286, blue: 0.4139637053, alpha: 1)
        tabBarController.tabBar.layer.borderColor = UIColor.systemGray5.cgColor
        tabBarController.tabBar.layer.borderWidth = 1
        tabBarController.tabBar.backgroundColor = .white
        tabBarController.tabBar.isTranslucent = true
        tabBarController.tabBar.barStyle = .default
        tabBarController.viewControllers = [mainPageVC, contactVC, profileVC, cartVC]
        
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
        return true
    }



}


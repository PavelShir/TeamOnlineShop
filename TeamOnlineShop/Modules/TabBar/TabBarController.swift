//
//  TabBarController.swift
//  TeamOnlineShop
//
//  Created by  Maksim Stogniy on 20.04.2024.
//

import UIKit

final class TabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupControllers()
        
    }
    
    private func setupControllers() {
        let mainVC = MainModuleBuilder.build()
        mainVC.tabBarItem = UITabBarItem(title: "Home", image: UIImage.Icons.home ?? UIImage(), selectedImage: nil)
        let profileVC = ProfileBuilder().buildProfileView()
        profileVC.tabBarItem = UITabBarItem(title: "Account", image: UIImage.Icons.user ?? UIImage(), selectedImage: nil)
        
        tabBar.tintColor = UIColor(named: Colors.greenPrimary)
        // If user.type == 'manager' add manager controller
        // Add wishlist here
        viewControllers = [mainVC, profileVC]
        
    }
    
}

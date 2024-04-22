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
        let managerVC = ManagerBuilder().buildManagerView()
        managerVC.tabBarItem = UITabBarItem(title: "Manager", image: UIImage.Icons.manager ?? UIImage(), selectedImage: nil)
        
        // Add wishlist here
        viewControllers = [mainVC, managerVC, profileVC]
        
    }
    
}

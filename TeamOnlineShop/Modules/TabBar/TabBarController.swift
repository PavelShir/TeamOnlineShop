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
        let navigationController = UINavigationController()
        let mainRouter = MainRouter(navigationVC: navigationController)
        mainRouter.prepareMainVC()
        navigationController.tabBarItem = UITabBarItem(title: "Home", image: UIImage.Icons.home ?? UIImage(), selectedImage: nil)
        let profileVC = ProfileBuilder().buildProfileView()
        profileVC.tabBarItem = UITabBarItem(title: "Account", image: UIImage.Icons.user ?? UIImage(), selectedImage: nil)
        
        tabBar.tintColor = UIColor(named: Colors.greenPrimary)
        // If user.type == 'manager' add manager controller
        let managerVC = ManagerBuilder().buildManagerView()
        managerVC.tabBarItem = UITabBarItem(title: "Manager", image: UIImage.Icons.manager ?? UIImage(), selectedImage: nil)
        
        let wishlistVC = WishlistBuilder().buildWishlistVC()
        wishlistVC.tabBarItem = UITabBarItem(title: "Wishlist", image: UIImage.Icons.wishlist ?? UIImage(), selectedImage: nil)
        
        viewControllers = [navigationController, wishlistVC, managerVC, profileVC]
        
    }
    
}

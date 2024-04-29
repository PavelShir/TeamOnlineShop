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
        tabBar.tintColor = UIColor(named: Colors.greenPrimary)
        setupControllers()
        updateManagerTabBarItemState()
    }
    
    private func setupControllers() {
        let navigationController = UINavigationController()
        
        let mainRouter = MainRouter(navigationVC: navigationController)
        mainRouter.prepareMainVC()
        navigationController.tabBarItem = UITabBarItem(title: "Home", image: UIImage.Icons.home ?? UIImage(), selectedImage: nil)
        
        let wishlistVC = WishlistBuilder().buildWishlistVC()
        wishlistVC.tabBarItem = UITabBarItem(title: "Wishlist", image: UIImage.Icons.wishlist ?? UIImage(), selectedImage: nil)
        
        let profileVC = ProfileBuilder().buildProfileView()
        profileVC.tabBarItem = UITabBarItem(title: "Account", image: UIImage.Icons.user ?? UIImage(), selectedImage: nil)
        
//        if UserManager.shared.getUserRole() == UserRole.user {
//            viewControllers = [navigationController, wishlistVC, profileVC]
//            return
//        }
//        
//        let managerVC = ManagerBuilder().buildManagerView()
//        managerVC.tabBarItem = UITabBarItem(title: "Manager", image: UIImage.Icons.manager ?? UIImage(), selectedImage: nil)
        
        viewControllers = [navigationController, wishlistVC, profileVC]
        
    }
    
    func updateManagerTabBarItemState() {
        let managerIndex = viewControllers?.firstIndex { $0.tabBarItem.title == "Manager" }

        if UserManager.shared.getUserRole() == .manager {
            if managerIndex == nil {
                let managerVC = ManagerBuilder().buildManagerView()
                managerVC.tabBarItem = UITabBarItem(title: "Manager", image: UIImage.Icons.manager ?? UIImage(), selectedImage: nil)
                viewControllers?.insert(managerVC, at: 2)
            }
        } else {
            if let index = managerIndex {
                viewControllers?.remove(at: index)
            }
        }
    }
}

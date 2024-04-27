//
//  SceneDelegate.swift
//  TeamOnlineShop
//
//  Created by Павел Широкий on 15.04.2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        
        let navVC = UINavigationController()
        let builder = CartBuilder(navigationVC: navVC)
        let router = builder.buildRouter()
        router.showCartModule(.sample)
        
//        let tabBarVC = TabBarController()
//        window.rootViewController = tabBarVC
        window.rootViewController = navVC
        window.makeKeyAndVisible()
        self.window = window
    }

}


//
//  SceneDelegate.swift
//  TeamOnlineShop
//
//  Created by Павел Широкий on 15.04.2024.
//

import UIKit
import FirebaseAuth

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        
        
        if Auth.auth().currentUser == nil {
            let loginVC = LoginViewController()
            window.rootViewController = loginVC
        } else {
            UserManager.shared.setUser(userObject: User(id: "1", username: "test", email: "test@m.ru", pass: "123", image: nil, type: UserType.user.rawValue, cart: [], wishList: [], location: ""))
            let tabBarController = TabBarController()
            window.rootViewController = tabBarController
        }
        
        window.makeKeyAndVisible()
        self.window = window
    }
}


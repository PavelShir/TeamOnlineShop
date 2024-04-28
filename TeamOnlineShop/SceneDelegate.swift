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
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        
        window?.makeKeyAndVisible()
        
        if UserDefaults.standard.bool(forKey: "isOnboardingCompleted"){
            checkAuthentication()
        } else {
            let vc = OnboardingViewController()
            vc.modalPresentationStyle = .fullScreen
            self.window?.rootViewController = vc
        }
    }
    
    func checkAuthentication() {
        if Auth.auth().currentUser == nil {
            let loginVC = LoginViewController()
            window?.rootViewController = loginVC
        } else {
            AuthManager.shared.fetchUser { [weak self] user, error in
                guard let user = user else { return }
                UserManager.shared.setUser(userObject: user)
                
                let tabBarController = TabBarController()
                self?.window?.rootViewController = tabBarController
            }
        }
    }
}




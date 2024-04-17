//
//  ProfileBuilder.swift
//  NewsToDayApp
//
//  Created by Maksim Stogniy on 16.04.2024.
//

import UIKit

protocol ProfileBuilderProtocol: AnyObject {
    
    func buildProfileView() -> UIViewController
    
}

final class ProfileBuilder: ProfileBuilderProtocol {
    
    let navigationController = UINavigationController()
    

    func buildProfileView() -> UIViewController {
        let router = ProfileRouter(navigationVC: navigationController)
        let presenter = ProfilePresenter(
            router: router
        )
        let vc = ProfileViewController(presenter: presenter)
        
        navigationController.viewControllers = [vc]
        return navigationController
    }
}

//
//  ManagerBuilder.swift
//  NewsToDayApp
//
//  Created by Maksim Stogniy on 20.04.2024.
//

import UIKit

protocol ManagerBuilderProtocol: AnyObject {
    
    func buildManagerView() -> UIViewController
    
}

final class ManagerBuilder: ManagerBuilderProtocol {
    
    let navigationController = UINavigationController()
    

    func buildManagerView() -> UIViewController {
        let router = ManagerRouter(navigationVC: navigationController)
        let presenter = ManagerPresenter(
            router: router
        )
        let vc = ManagerViewController(presenter: presenter)
        
        navigationController.viewControllers = [vc]
        return navigationController
    }
}

//
//  MainRouter.swift
//  TeamOnlineShop
//
//  Created by Новый пользователь on 21.04.2024.
//

import UIKit

final class MainRouter {
    let navigationVC: UINavigationController

    init(navigationVC: UINavigationController) {
        self.navigationVC = navigationVC
    }

    func prepareMainVC() {
        let mainVC = MainModuleBuilder.build(router: self)
        navigationVC.viewControllers = [mainVC]
    }
}


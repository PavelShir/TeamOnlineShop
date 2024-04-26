//
//  MainRouter.swift
//  TeamOnlineShop
//
//  Created by Новый пользователь on 21.04.2024.
//

import UIKit
import PlatziFakeStore

final class MainRouter {
    let navigationVC: UINavigationController

    init(navigationVC: UINavigationController) {
        self.navigationVC = navigationVC
    }

    func prepareMainVC() {
        let mainVC = MainModuleBuilder.build(router: self)
        navigationVC.viewControllers = [mainVC]
    }
    
    func showSearch(data: [PlatziFakeStore.Product]) {
        let vc = SearchModuleBuilder.build(products: data)
        navigationVC.pushViewController(vc, animated: true)
    }
    
    func showProductDetail(data: Product) {
        let detailVC = DetailBuilder(navigationVC: navigationVC).buildDetailVC(data: data)
        navigationVC.pushViewController(detailVC, animated: true)
    }
}


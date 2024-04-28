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
    
    func showSearch(data: [Product], serachText: String) {
       
        let vc = SearchModuleBuilder.build(
            router: self,
            products: data,
            searchText: serachText)
        navigationVC.pushViewController(vc, animated: true)
    }
    
    func showProductDetail(data: Product) {
        let detailVC = DetailBuilder(navigationVC: navigationVC).buildDetailVC(data: data)
        navigationVC.pushViewController(detailVC, animated: true)
    }
    
    func goToCartVC() {
        let builder = CartBuilder(navigationVC: navigationVC)
        let router = builder.buildRouter()
        router.showCartModule()
    }
}


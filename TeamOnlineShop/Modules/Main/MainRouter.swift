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
    
//    func showDetail(data: PlatziFakeStore.Product) {
//        let vc = DetailViewController(
//            name: data.title,
//            image: data.images.first,
//            price: data.price,
//            text: data.description)
//        navigationVC.pushViewController(vc, animated: true)
//    }
}


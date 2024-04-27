//
//  WishlistRouter.swift
//  TeamOnlineShop
//
//  Created by  Maksim Stogniy on 25.04.2024.
//

import UIKit

protocol WishlistRouterProtocol: AnyObject {
    
    init(navigationVC: UINavigationController)
    func showProductDetail(data: Product)
    func goToCartVC()
    
}

final class WishlistRouter: WishlistRouterProtocol {

    let navigationVC: UINavigationController
    
    required init(navigationVC: UINavigationController) {
        self.navigationVC = navigationVC
    }
    
    func showProductDetail(data: Product) {
        let detailVC = DetailBuilder(navigationVC: navigationVC).buildDetailVC(data: data)
        navigationVC.pushViewController(detailVC, animated: true)
    }
    
    func goToCartVC() {
        print("go to cart")
    }
}

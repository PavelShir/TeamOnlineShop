//
//  WishlistPresenter.swift
//  TeamOnlineShop
//
//  Created by  Maksim Stogniy on 25.04.2024.
//

import UIKit

protocol WishlistRouterProtocol: AnyObject {
    
    init(navigationVC: UINavigationController)
    func goToDetailVC()
    func goToCartVC()
    
}

final class WishlistRouter: WishlistRouterProtocol {

    weak var navigationVC: UINavigationController?
    
    required init(navigationVC: UINavigationController) {
        self.navigationVC = navigationVC
    }
    
    func goToDetailVC() {
        // go to detail
    }
    
    func goToCartVC() {
        // go to cart
    }
}

//
//  DetailPresenter.swift
//  TeamOnlineShop
//
//  Created by  Maksim Stogniy on 25.04.2024.
//

import UIKit

protocol DetailRouterProtocol: AnyObject {
    
    init(navigationVC: UINavigationController)
    func dismissDetailVC()
    func goToCartVC()
    
}

final class DetailRouter: DetailRouterProtocol {

    weak var navigationVC: UINavigationController?
    
    required init(navigationVC: UINavigationController) {
        self.navigationVC = navigationVC
    }
    
    func dismissDetailVC() {
        navigationVC?.popViewController(animated: true)
    }
    
    func goToCartVC() {
        // go to cart
    }
}

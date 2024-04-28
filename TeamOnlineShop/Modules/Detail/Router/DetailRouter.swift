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
    func goToPaymentsVC()

}

final class DetailRouter: DetailRouterProtocol {

    let navigationVC: UINavigationController
    
    required init(navigationVC: UINavigationController) {
        self.navigationVC = navigationVC
    }
    
    func dismissDetailVC() {
        navigationVC.popViewController(animated: true)
    }
    
    func goToCartVC() {
        let builder = CartBuilder(navigationVC: navigationVC)
        let router = builder.buildRouter()
        router.showCartModule()
    }
    
    func goToPaymentsVC() {
        let vc = PaymentsViewController()
        navigationVC.present(vc, animated: true)
    }
}

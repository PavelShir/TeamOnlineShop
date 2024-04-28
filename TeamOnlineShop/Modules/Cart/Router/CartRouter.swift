//
//  CartRouter.swift
//  TeamOnlineShop
//
//  Created by Сергей П on 26.04.2024.
//

import UIKit

protocol CartRouterProtocol: AnyObject {
    init(navigationVC: UINavigationController, builder: CartBuilder)
    func dismissCartVC()
    func goToPaymentsVC(onContinue completion: @escaping () -> Void)
}

final class CartRouter: CartRouterProtocol {
    private let builder: CartBuilder
    private let navigationVC: UINavigationController
    
    required init(
        navigationVC: UINavigationController,
        builder: CartBuilder
    ) {
        self.navigationVC = navigationVC
        self.builder = builder
    }
    
    func dismissCartVC() {
        navigationVC.popViewController(animated: true)
    }
    
    func showCartModule() {
        let vc = builder.buildCartVC(router: self)
        navigationVC.pushViewController(vc, animated: true)
    }
    
    func goToPaymentsVC(onContinue completion: @escaping () -> Void) {
        let vc = PaymentsViewController()
        vc.onContinue = completion
        navigationVC.present(vc, animated: true)
    }
}

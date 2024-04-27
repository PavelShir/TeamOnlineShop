//
//  CartRouter.swift
//  TeamOnlineShop
//
//  Created by Сергей П on 26.04.2024.
//

import UIKit

protocol CartRouterProtocol: AnyObject {
    
    init(navigationVC: UINavigationController)
    func dismissCartVC()
    func goToPaymentsVC()
}

final class CartRouter: CartRouterProtocol {
    
    weak var navigationVC: UINavigationController?
    
    required init(navigationVC: UINavigationController) {
        self.navigationVC = navigationVC
    }
    
    func dismissCartVC() {
        navigationVC?.popViewController(animated: true)
    }
    
    func goToPaymentsVC() {
        // go to payments
    }
    
    
}

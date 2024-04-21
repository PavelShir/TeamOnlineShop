//
//  ProductRouter.swift
//  TeamOnlineShop
//
//  Created by  Maksim Stogniy on 20.04.2024.
//

import UIKit

protocol ProductRouterProtocol: AnyObject {
    init(navigationVC: UINavigationController)
    func dismissProductVC()
}

final class ProductRouter: ProductRouterProtocol {
    weak var navigationVC: UINavigationController?
    
    required init(navigationVC: UINavigationController) {
        self.navigationVC = navigationVC
    }
    
    func dismissProductVC() {    navigationVC?.popViewController(animated: true)
    }
}

//
//  CategoryRouter.swift
//  TeamOnlineShop
//
//  Created by  Maksim Stogniy on 20.04.2024.
//

import UIKit

protocol CategoryRouterProtocol: AnyObject {
    init(navigationVC: UINavigationController)
    func dismissCategoryVC()
}

final class CategoryRouter: CategoryRouterProtocol {
    weak var navigationVC: UINavigationController?
    
    required init(navigationVC: UINavigationController) {
        self.navigationVC = navigationVC
    }
    
    func dismissCategoryVC() {    navigationVC?.popViewController(animated: true)
    }
}

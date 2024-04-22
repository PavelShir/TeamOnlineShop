//
//  ProductBuilder.swift
//  TeamOnlineShop
//
//  Created by  Maksim Stogniy on 20.04.2024.
//

import UIKit

protocol ProductBuilderProtocol: AnyObject {
    func buildProductVC(label: String, action: ManagerActions.Product) -> UIViewController?
}

final class ProductBuilder: ProductBuilderProtocol {
    
    weak var navigationVC: UINavigationController?
    
    init(navigationVC: UINavigationController) {
        self.navigationVC = navigationVC
    }
    
    func buildProductVC(label: String, action: ManagerActions.Product) -> UIViewController? {
        guard let navigationVC = navigationVC else { return nil}
        let router = ProductRouter(navigationVC: navigationVC)
        let presenter = ProductPresenter(router: router, action: action)
        let vc = ProductViewController(presenter: presenter, label: label)
        return vc
    }
}

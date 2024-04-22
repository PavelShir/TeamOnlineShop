//
//  CategoryBuilder.swift
//  TeamOnlineShop
//
//  Created by  Maksim Stogniy on 20.04.2024.
//

import UIKit

protocol CategoryBuilderProtocol: AnyObject {
    func buildCategoryVC(label: String, action: ManagerActions.Category) -> UIViewController?
}

final class CategoryBuilder: CategoryBuilderProtocol {
    
    weak var navigationVC: UINavigationController?
    
    init(navigationVC: UINavigationController) {
        self.navigationVC = navigationVC
    }
    
    func buildCategoryVC(label: String, action: ManagerActions.Category) -> UIViewController? {
        guard let navigationVC = navigationVC else { return nil}
        let router = CategoryRouter(navigationVC: navigationVC)
        let presenter = CategoryPresenter(router: router, action: action)
        let vc = CategoryViewController(presenter: presenter, label: label)
        return vc
    }
}

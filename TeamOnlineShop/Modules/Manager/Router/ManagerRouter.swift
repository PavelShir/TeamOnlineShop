//
//  ManagerRouter.swift
//  NewsToDayApp
//
//  Created by Maksim Stogniy on 20.04.2024.
//

import Foundation
import UIKit

protocol ManagerRouterProtocol: AnyObject {
    
    init(navigationVC: UINavigationController)
    
    func pushToCategory(label: String, action: ManagerActions.Category)
    
    func pushToProduct(label: String, action: ManagerActions.Product)
    
}

final class ManagerRouter: ManagerRouterProtocol {
    weak var navigationVC: UINavigationController?
    
    required init(navigationVC: UINavigationController) {
        self.navigationVC = navigationVC
    }
    
    func pushToCategory(label: String, action: ManagerActions.Category) {
        guard let navigationVC = navigationVC else { return }
        let categoryVC = CategoryBuilder(navigationVC: navigationVC).buildCategoryVC(label: label, action: action)
        navigationVC.pushViewController(categoryVC!, animated: true)
    }
    
    func pushToProduct(label: String, action: ManagerActions.Product) {
        
    }
    
    func pushToUpdateProduct(label: String, action: ManagerActions.Product) {
        
    }
    
    func pushToDeleteProduct(label: String, action: ManagerActions.Product) {
        
    }
}

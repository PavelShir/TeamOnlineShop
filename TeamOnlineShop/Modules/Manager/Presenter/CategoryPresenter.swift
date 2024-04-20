//
//  CategoryPresenter.swift
//  TeamOnlineShop
//
//  Created by  Maksim Stogniy on 20.04.2024.
//

import Foundation


protocol CategoryPresenterViewProtocol: AnyObject {
    
}

protocol CategoryPresenterProtocol: AnyObject {
    var action: ManagerActions.Category { get }
    
    init(router: CategoryRouterProtocol, action: ManagerActions.Category)
    func dismissCategoryVC()
}

final class CategoryPresenter: CategoryPresenterProtocol {
    weak var view: CategoryPresenterViewProtocol?
    var router: CategoryRouterProtocol?
    var action: ManagerActions.Category
    
    required init(router: CategoryRouterProtocol, action: ManagerActions.Category) {
        self.router = router
        self.action = action
    }
    
    func dismissCategoryVC() {
        router?.dismissCategoryVC()
    }
}

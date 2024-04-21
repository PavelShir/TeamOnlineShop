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
    func saveChanges(category: Category)
    func searchCategories(query: String)
}

final class CategoryPresenter: CategoryPresenterProtocol {
    weak var view: CategoryPresenterViewProtocol?
    var router: CategoryRouterProtocol?
    var action: ManagerActions.Category
    var category: Category?
    
    required init(router: CategoryRouterProtocol, action: ManagerActions.Category) {
        self.router = router
        self.action = action
    }
    
    func dismissCategoryVC() {
        router?.dismissCategoryVC()
    }
    
    func saveChanges(category: Category) {
        // call here network method with category and action
    }
    
    func searchCategories(query: String) {
        // call here network method with query to find categories
        // after set products to view base on action
        // if update - get first element from array
        // if delete - all found elements
    }
}

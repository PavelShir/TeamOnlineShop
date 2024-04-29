//
//  CategoryPresenter.swift
//  TeamOnlineShop
//
//  Created by  Maksim Stogniy on 20.04.2024.
//

import Foundation
import PlatziFakeStore


protocol CategoryPresenterViewProtocol: AnyObject {
    
    func showAlert(title: String, message: String)
}

protocol CategoryPresenterProtocol: AnyObject {
    var action: ManagerActions.Category { get }
    
    init(router: CategoryRouterProtocol, action: ManagerActions.Category)
    func dismissCategoryVC()
    func saveChanges(newCategory: PlatziFakeStore.NewCategory)
    func searchCategories(query: String)
}

final class CategoryPresenter: CategoryPresenterProtocol {
    
    weak var view: CategoryPresenterViewProtocol?
    var router: CategoryRouterProtocol?
    var action: ManagerActions.Category
    var category: PlatziFakeStore.Category?
    
    required init(router: CategoryRouterProtocol, action: ManagerActions.Category) {
        self.router = router
        self.action = action
    }
    
    func dismissCategoryVC() {
        router?.dismissCategoryVC()
    }
    
    func saveChanges(newCategory: PlatziFakeStore.NewCategory) {
        if let categoryId = category?.id {
            PlatziStore.shared.updateCategory(withId: categoryId, new: newCategory) { [weak self] result in
                switch result {
                case .success(let category):
                    DispatchQueue.main.async {
                        self?.view?.showAlert(title: "Success", message: "Succesfully update category")
                    }
                case .failure(let error):
                    DispatchQueue.main.async {
                        self?.view?.showAlert(title: "Error", message: "Error during updating category: \(error)")
                    }
                }
            }
        } else {
            PlatziStore.shared.create(category: newCategory) { [weak self] result in
                switch result {
                case .success(let category):
                    DispatchQueue.main.async {
                        self?.view?.showAlert(title: "Success", message: "Succesfully add new category")
                    }
                case .failure(let error):
                    DispatchQueue.main.async {
                        self?.view?.showAlert(title: "Error", message: "Error during adding category: \(error)")
                    }
                }
            }
        }
    }
    
    func searchCategories(query: String) {
        // call here network method with query to find categories
        // after set products to view base on action
        // if update - get first element from array
        // if delete - all found elements
    }
}

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
    func setCategoriesForTable(_ categories: [Category])
    func setCategoriesForSelector(_ categories: [Category])
}

protocol CategoryPresenterProtocol: AnyObject {
    var action: ManagerActions.Category { get }
    
    init(router: CategoryRouterProtocol, action: ManagerActions.Category)
    func dismissCategoryVC()
    func saveChanges(newCategory: PlatziFakeStore.NewCategory, id: Int?)
    func searchCategories(query: String)
    func loadCategories()
}

final class CategoryPresenter: CategoryPresenterProtocol {
    
    weak var view: CategoryPresenterViewProtocol?
    var router: CategoryRouterProtocol?
    var action: ManagerActions.Category
    var category: PlatziFakeStore.Category?
    private var categoriesArray = [Category]()
    
    required init(router: CategoryRouterProtocol, action: ManagerActions.Category) {
        self.router = router
        self.action = action
    }
    
    func dismissCategoryVC() {
        router?.dismissCategoryVC()
    }
    
    func saveChanges(newCategory: PlatziFakeStore.NewCategory, id: Int?) {
        switch self.action {
        case .add:
            PlatziStore.shared.create(category: newCategory) { [weak self] result in
                switch result {
                case .success(_):
                    DispatchQueue.main.async {
                        self?.view?.showAlert(title: "Success", message: "Succesfully add new category")
                    }
                case .failure(let error):
                    DispatchQueue.main.async {
                        self?.view?.showAlert(title: "Error", message: "Error during adding category: \(error)")
                    }
                }
            }
            return
        case .update:
            if let categoryId = id {
                PlatziStore.shared.updateCategory(withId: categoryId, new: newCategory) { [weak self] result in
                    switch result {
                    case .success(_):
                        DispatchQueue.main.async {
                            self?.view?.showAlert(title: "Success", message: "Succesfully update category")
                        }
                    case .failure(let error):
                        DispatchQueue.main.async {
                            self?.view?.showAlert(title: "Error", message: "Error during updating category: \(error)")
                        }
                    }
                }
            }
            return
            
        case .delete:
            if let categoryId = id {
                PlatziStore.shared.deleteCategory(withId: categoryId){ [weak self] result in
                    switch result {
                    case .success(_):
                        DispatchQueue.main.async {
                            self?.view?.showAlert(title: "Success", message: "Succesfully remove product")
                            let cats = self?.categoriesArray.filter{ $0.id != categoryId }
                            self?.view?.setCategoriesForTable(cats ?? [])
                        }
                    case .failure(let error):
                        DispatchQueue.main.async {
                            self?.view?.showAlert(title: "Error", message: "Error during removing product: \(error)")
                        }
                    }
                }
            }
            return
        }
    }
    
    func searchCategories(query: String) {
        // call here network method with query to find categories
        // after set products to view base on action
        // if update - get first element from array
        // if delete - all found elements
    }
    
    func loadCategories() {
        PlatziStore.shared.categoryList(limit: 20) { [weak self] result in
            switch result {
            case .success(let categories):
                DispatchQueue.main.async {
                    let cats = categories.map { Category(fromDTO: $0) }
                    self?.categoriesArray = cats
                    if self?.action == .update {
                        self?.view?.setCategoriesForSelector(cats)
                    } else if self?.action == .delete {
                        
                        self?.view?.setCategoriesForTable(cats)
                    }
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    print("Error fetching categories: \(error)")
                }
            }
        }
    }
}
